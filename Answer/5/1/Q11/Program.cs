using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

namespace Client
{
    internal class Program
    {
        static async Task Main(string[] args)
        {
            var config = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .Build();

            var ip = (config["IpAddress"] ?? "localhost").Trim();
            var port = (config["Port"] ?? "5000").Trim();
            var baseUri = new Uri($"http://{ip}:{port}");

            using var client = new HttpClient { BaseAddress = baseUri };
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(new System.Net.Http.Headers.MediaTypeWithQualityHeaderValue("application/json"));

            while (true)
            {
                Menu.MainMenu();
                string? optionRaw = Console.ReadLine();

                if (!int.TryParse(optionRaw, out int option) || option < 1 || option > 3)
                {
                    Console.WriteLine("Invalid option, please try again with only integers in 1–3 range.");
                    continue;
                }

                if (option == 1)
                {
                    await ListBooksAsync(client);
                }
                else if (option == 2)
                {
                    await DeleteBookFlowAsync(client);
                }
                else // option == 3
                {
                    Console.WriteLine("Exited!");
                    return;
                }
            }
        }

        private static async Task ListBooksAsync(HttpClient client)
        {
            var resp = await client.GetAsync("/list");
            var body = await resp.Content.ReadAsStringAsync();

            var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
            var books = JsonSerializer.Deserialize<List<BookDTO>>(body, options) ?? new List<BookDTO>();

            if (books.Count == 0)
            {
                Console.WriteLine("[]");
            }
            else
            {
                Console.WriteLine(Helper.Stringify(books));
            }
        }

        private static async Task DeleteBookFlowAsync(HttpClient client)
        {
            int id;
            while (true)
            {
                Menu.DeleteMenu();
                string? idRaw = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(idRaw) || !int.TryParse(idRaw.Trim(), out id) || id < 1)
                {
                    Console.WriteLine("Invalid ID!");
                    continue;
                }
                break;
            }

            var requestUri = $"/delete?id={WebUtility.UrlEncode(id.ToString())}";
            var resp = await client.DeleteAsync(requestUri);
            var body = await resp.Content.ReadAsStringAsync();

            try
            {
                var msg = JsonSerializer.Deserialize<string>(body);
                if (msg is not null)
                    Console.WriteLine(msg);
                else
                    Console.WriteLine(body);
            }
            catch
            {
                Console.WriteLine(body);
            }
        }
    }
}
