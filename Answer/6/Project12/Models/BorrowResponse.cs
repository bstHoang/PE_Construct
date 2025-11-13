using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project12.Models
{
    public class BorrowResponse
    {
        public string Status { get; set; }
        public string Message { get; set; }
        public Movie Movie { get; set; }
    }
}
