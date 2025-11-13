using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project11.DTO
{
    public class MovieDto
    {
        public int MovieId { get; set; }
        public string Title { get; set; }
        public int? ReleaseYear { get; set; }
        public string Genre { get; set; }
        public int AvailableCopies { get; set; }
        public DirectorDto Director { get; set; }
    }
}
