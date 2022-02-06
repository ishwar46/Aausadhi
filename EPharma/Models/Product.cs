using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EPharma.Models
{
    public class Product
    {
        [Key]
        public int ID { get; set; }

        public string Name { get; set; }

        public Decimal SellPrice { get; set; }
    }
}