using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ContrutoraApp
{
    public class Contas
    {
        public Int32 id { get; set; }
        public String desc_conta { get; set; }
        public String tipo { get; set; }
        public Int32 num_parcela { get; set; }
        public String num_parcela_string { get; set; }
        public Double valor { get; set; }
        public String valor_string { get; set; }
        public String nm_cadastrou { get; set; }
        public String dt_cadastrou { get; set; }
    }
}