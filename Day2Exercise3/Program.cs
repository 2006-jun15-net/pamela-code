using System;

namespace Day2Exercise3
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter a number:");
            string userInput = Console.ReadLine();
            int number = int.Parse(userInput);

            
            while(number != 1)
            {
                Console.WriteLine(number);

                if (number % 2 == 0)
                {
                    number = number / 2;
                }
                else
                {
                    number = number * 3 + 1;
                }

            }
            Console.Write(number);
            
        
        
        }
    }
}
