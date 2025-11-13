using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Project11.DTO;
//using Project11.Models;
using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace Project11
{
    class Program
    {
        static async Task Main(string[] args)
        {
            //var configuration = new ConfigurationBuilder()
            //    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
            //    .Build();

            //var connectionString = configuration["ConnectionStrings:MyCnn"];
            //var portStr = configuration["Port"];
            //var ipAddressStr = configuration["IpAddress"];

            //if (string.IsNullOrEmpty(connectionString) || string.IsNullOrEmpty(portStr) || string.IsNullOrEmpty(ipAddressStr)) // Updated check
            //{
            //    Console.WriteLine("Error: Required configuration values are missing.");
            //    return;
            //}

            //var optionsBuilder = new DbContextOptionsBuilder<MovieStoreDbContext>();
            //optionsBuilder.UseSqlServer(connectionString);

            //using var listener = new TcpListener(IPAddress.Parse(ipAddressStr), int.Parse(portStr)); // Updated to use the specific IP
            //listener.Start();
            //Console.WriteLine($"Server started");

            //while (true)
            //{
            //    using var client = await listener.AcceptTcpClientAsync();
            //    using var stream = client.GetStream();
            //    Console.WriteLine("Client connected");
            //    try
            //    {
            //        var buffer = new byte[1024];
            //        var bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length);
            //        var request = Encoding.UTF8.GetString(buffer, 0, bytesRead);

            //        var deserializeOptions = new JsonSerializerOptions
            //        {
            //            PropertyNameCaseInsensitive = true
            //        };
            //        var requestObj = JsonSerializer.Deserialize<MovieRequest>(request, deserializeOptions);

            //        if (requestObj == null)
            //        {
            //            var errorResponse = "Invalid request format";
            //            var errorBytes = Encoding.UTF8.GetBytes(errorResponse);
            //            await stream.WriteAsync(errorBytes, 0, errorBytes.Length);
            //            continue;
            //        }

            //        using var context = new MovieStoreDbContext(optionsBuilder.Options);
            //        var movie = await context.Movies
            //            .Include(m => m.Director)
            //            .FirstOrDefaultAsync(m => m.MovieId == requestObj.MovieId);

            //        Console.WriteLine($"Querying for MovieId: {requestObj.MovieId}, Result: {(movie != null ? movie.Title : "null")}");

            //        string jsonResponse;
            //        if (movie == null)
            //        {
            //            jsonResponse = JsonSerializer.Serialize(new { Status = "Error", Message = "Movie does not exist" });
            //        }
            //        else if (movie.AvailableCopies <= 0)
            //        {
            //            jsonResponse = JsonSerializer.Serialize(new { Status = "Error", Message = "You cannot borrow that movie" });
            //        }
            //        else
            //        {
            //            movie.AvailableCopies--;
            //            await context.SaveChangesAsync();

            //            var movieDto = new MovieDto
            //            {
            //                MovieId = movie.MovieId,
            //                Title = movie.Title,
            //                ReleaseYear = movie.ReleaseYear,
            //                Genre = movie.Genre,
            //                AvailableCopies = (int)movie.AvailableCopies,
            //                Director = movie.Director != null ? new DirectorDto
            //                {
            //                    FirstName = movie.Director.FirstName,
            //                    LastName = movie.Director.LastName
            //                } : null
            //            };

            //            jsonResponse = JsonSerializer.Serialize(new { Status = "Success", Movie = movieDto });
            //        }

            //        var responseBytes = Encoding.UTF8.GetBytes(jsonResponse);
            //        await stream.WriteAsync(responseBytes, 0, responseBytes.Length);
            //    }
            //    catch (Exception ex)
            //    {
            //        Console.WriteLine($"Error: {ex.Message}");
            //        var errorResponse = "An internal server error occurred.";
            //        var errorBytes = Encoding.UTF8.GetBytes(errorResponse);
            //        await stream.WriteAsync(errorBytes, 0, errorBytes.Length);
            //    }
            //}
        }
    }
}