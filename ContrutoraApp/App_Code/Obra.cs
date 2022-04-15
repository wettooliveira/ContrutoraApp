using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ContrutoraApp
{
    public class Obra
    {
        public Int32 id { get; set; }
        public String acao { get; set; }
        public String nome { get; set; }
        public String responsavel { get; set; }
        public Endereco endereco { get; set; }
        public Cliente cliente { get; set; }
        public Double valor { get; set; }

    }
}