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
            var serverHost = Environment.GetEnvironmentVariable("SERVER_HOST");
            var response = new HttpClient().GetStringAsync(serverHost).Result;
            Console.WriteLine(response);
        }
    }
}
