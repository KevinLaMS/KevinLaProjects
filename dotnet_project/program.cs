using System;
using System.Diagnostics;

class Program
{
    static void Main()
    {
        var sw = Stopwatch.StartNew();

        // Simulate some work
        for (int i = 0; i < 1_000_000; i++)
        {
            var x = Math.Sqrt(i);
        }

        sw.Stop();
        Console.WriteLine($"Work completed in {sw.ElapsedMilliseconds} ms");
    }
}