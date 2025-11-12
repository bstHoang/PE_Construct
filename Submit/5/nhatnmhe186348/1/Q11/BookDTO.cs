using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Client
{
    internal class BookDTO
    {
        public int BookId { get; set; }
        public string Title { get; set; }
        public int PublicationYear { get; set; }
        public string Genres { get; set; }
        public List<Author> Authors { get; set; }
    }

    internal class Author
    {
        public string Name { get; set; }
        public int BirthYear { get; set; }
    }
}
