using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ContrutoraApp
{
    public class ContaBanco
    {
        public Int32 id { get; set; }
        public Int32 cod_banco { get; set; }
        public String tipo { get; set; }
        public String ds_agencia { get; set; }

        public String ds_conta { get; set; }
    }
}