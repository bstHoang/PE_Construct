using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace Server
{
    internal class Helper
    {
        private Helper() { }

        /// <summary>
        /// Student must use this method to format any response from the Server to Client
        /// </summary>
        /// <param name="response">response attribute from HTTP Listener</param>
        /// <param name="data">the response payload</param>
        /// <param name="contentType">data type of payload</param>
        /// <param name="statusCode">http status code</param>
        /// <returns></returns>
        /// <exception cref="ArgumentNullException"></exception>
        public static async Task WriteJsonResponse(HttpListenerResponse response, object data, string contentType, HttpStatusCode statusCode)
        {
            if(response == null)
            {
                throw new ArgumentNullException(nameof(response));
            }
            string json = JsonSerializer.Serialize(data);
            byte[] buffer = Encoding.UTF8.GetBytes(json);
            response.ContentType = contentType;
            response.ContentLength64 = buffer.Length;
            response.StatusCode = (int)statusCode;
            await response.OutputStream.WriteAsync(buffer, 0, buffer.Length);
        }
    }
}
