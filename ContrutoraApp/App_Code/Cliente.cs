using System;

using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ContrutoraApp
{
    public class Cliente
    {
        public Int32 id { get; set; }
        public String RazaoSocial { get; set; }
        public String CNPJ { get; set; }
        public String IE { get; set; }
        public String tel { get; set; }
        public String obs { get; set; }
        public Endereco endereco { get; set; }
        public String nm_cadastrou { get; set; }
        public DateTime dt_cadastrou { get; set; }



    }
}