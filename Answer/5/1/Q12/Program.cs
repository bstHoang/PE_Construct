using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Q12.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;

namespace Server
{
    internal class Program
    {
        static async Task Main(string[] args)
        {
            var config = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .Build();

            var ip = config["IpAddress"] ?? "localhost";
            var port = config["Port"] ?? "5000";

            ip = ip.Trim();
            port = port.Trim();

            var prefix = $"http://{ip}:{port}/";

            var listener = new HttpListener();
            listener.Prefixes.Add(prefix);
            listener.Start();

            while (true)
            {
                var ctx = await listener.GetContextAsync();
                _ = Task.Run(() => HandleContextAsync(ctx));
            }
        }

        private static async Task HandleContextAsync(HttpListenerContext ctx)
        {
            var req = ctx.Request;
            var resp = ctx.Response;

            string path = req.Url?.AbsolutePath ?? "/";

            if (req.HttpMethod == "GET" && path.Equals("/list", StringComparison.OrdinalIgnoreCase))
            {
                using var db = new LibraryContext();
                try
                {
                    var books = await db.Books
                    .Include(b => b.Authors)
                    .Include(b => b.Genre)
                    .ToListAsync();

                    var dtoList = books.Select(b => new BookDTO
                    {
                        BookId = b.BookId,
                        Title = b.Title,
                        PublicationYear = b.PublicationYear ?? 0,
                        Genres = b.Genre?.GenreName ?? string.Empty,
                        Authors = b.Authors.Select(a => new Author
                        {
                            Name = a.Name,
                            BirthYear = a.BirthYear ?? 0
                        }).ToList()
                    }).ToList();

                    await Helper.WriteJsonResponse(resp, dtoList, "application/json; charset=utf-8", HttpStatusCode.OK);
                    resp.Close();
                    return;

                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Exception type: {ex.GetType().Name}");
                    Console.WriteLine($"Message: {ex.Message}");

                    if (ex is AggregateException aggr)
                    {
                        foreach (var inner in aggr.InnerExceptions)
                            Console.WriteLine($"Inner: {inner.GetType().Name} - {inner.Message}");
                    }

                }
            }

            if (req.HttpMethod == "DELETE" && path.Equals("/delete", StringComparison.OrdinalIgnoreCase))
            {
                var idStr = req.QueryString["id"];
                if (string.IsNullOrWhiteSpace(idStr) || !int.TryParse(idStr, out int id) || id < 1)
                {
                    await Helper.WriteJsonResponse(resp, "Invalid ID!", "application/json; charset=utf-8", HttpStatusCode.BadRequest);
                    resp.Close();
                    return;
                }

                using var db = new LibraryContext();
                var book = await db.Books
                    .Include(b => b.Authors)
                    .FirstOrDefaultAsync(b => b.BookId == id);

                if (book == null)
                {
                    await Helper.WriteJsonResponse(resp, "Book does not exist!", "application/json; charset=utf-8", HttpStatusCode.NotFound);
                    resp.Close();
                    return;
                }

                db.Books.Remove(book);
                await db.SaveChangesAsync();

                await Helper.WriteJsonResponse(resp, "Deleted.", "application/json; charset=utf-8", HttpStatusCode.OK);
                resp.Close();
                return;
            }

            // unknown endpoint
            await Helper.WriteJsonResponse(resp, "Not Found", "application/json; charset=utf-8", HttpStatusCode.NotFound);
            resp.Close();
        }
    }

    internal class BookDTO
    {
        public int BookId { get; set; }
        public string Title { get; set; }
        public int PublicationYear { get; set; }
        public string Genres { get; set; }
        public List<Author> Authors { get; set; }
    }

    internal class Author
    {
        public string Name { get; set; }
        public int BirthYear { get; set; }
    }
}
