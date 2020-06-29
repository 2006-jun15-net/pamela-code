using System;

namespace Day2Exercise1
{
    class Program
    {
        static void Main(string[] args)
        {
            int n = 8;
            for(int i = 1; i<=8; i++)
            {
                Console.WriteLine(new string(' ', n-i) + new string('#',i));
            }
            
        }
    }
}
