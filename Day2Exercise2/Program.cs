using System;

namespace Day2Exercise2
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter a number for the staircase:");

            string userInput = Console.ReadLine();
            int n = int.Parse(userInput);

            for(int i = 1; i<=n; i++)
            {
                Console.WriteLine(new string(' ', n-i) + new string('#',i));
            }

        }
    }
}
