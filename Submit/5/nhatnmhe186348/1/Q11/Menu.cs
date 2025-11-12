using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Client
{
    internal class Menu
    {
        private Menu() { }

        public static void MainMenu()
        {
            Console.WriteLine("""
                ======== Book Store ======
                1. List Book
                2. Delete Book
                3. Exit

                """);
            Console.Write("Option: ");
        }

        public static void DeleteMenu()
        {
            Console.Write("Book Id: ");
        }
    }
}
