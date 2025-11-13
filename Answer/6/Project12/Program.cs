using System;
using System.IO;
using System.Net.Sockets;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Configuration;
using Project12.Models;

namespace Project12
{
    class Program
    {
        static void Main(string[] args)
        {
            var configuration = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .Build();

            var portStr = configuration["Port"];
            var ipAddress = configuration["IpAddress"];
            int port = int.Parse(portStr);

            while (true)
            {
                Utils.prompt();
                var input = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(input))
                {
                    Console.WriteLine("Exiting client");
                    break;
                }

                if (!int.TryParse(input, out var movieId))
                {
                    Console.WriteLine("Invalid movie ID, please enter an integer");
                    continue;
                }
                else if (movieId <= 0)
                {
                    Console.WriteLine("Invalid movie ID, please enter an integer greater than 0");
                    continue;
                }

                try
                {
                    using var client = new TcpClient(ipAddress, port);
                    using var stream = client.GetStream();

                    var request = new { MovieId = movieId };
                    var requestJson = JsonSerializer.Serialize(request);
                    var requestBytes = Encoding.UTF8.GetBytes(requestJson);
                    stream.Write(requestBytes, 0, requestBytes.Length);

                    var buffer = new byte[4096];
                    var bytesRead = stream.Read(buffer, 0, buffer.Length);
                    var response = Encoding.UTF8.GetString(buffer, 0, bytesRead);

                    var deserializeOptions = new JsonSerializerOptions
                    {
                        PropertyNameCaseInsensitive = true
                    };
                    var respObj = JsonSerializer.Deserialize<BorrowResponse>(response, deserializeOptions);

                    if (respObj.Status == "Success")
                    {
                        Console.WriteLine(Utils.Stringify(respObj));
                    }
                    else
                    {
                        Console.WriteLine(respObj.Message);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error connecting to server: {ex.Message}");
                }
            }
        }
    }
}