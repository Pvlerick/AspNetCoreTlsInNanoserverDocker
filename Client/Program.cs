using System;
using System.Net.Http;
using System.Threading.Tasks;

namespace Client
{
    class Program
    {
        static void Main(string[] args)
        {
            var delay = TimeSpan.FromSeconds(5);
            Console.WriteLine($"Waiting {delay} for the server to start...");
            Task.Delay(TimeSpan.FromSeconds(5)).Wait();

            var targetUrl = Environment.GetEnvironmentVariable("TARGET_URL");
            Console.WriteLine($"Making request to {targetUrl}");
            var response = new HttpClient().GetStringAsync(targetUrl).Result;
            Console.WriteLine(response);
        }
    }
}
