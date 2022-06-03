using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ContrutoraApp
{
    public class Contas
    {
        public Int32 id { get; set; }

        public Int32 num_conta { get; set; }
        public String desc_conta { get; set; }
        public String nf { get; set; }
        public Int32 num_parcela { get; set; }
        public String num_parcela_string { get; set; }
        public String tipo_pgto { get; set; }
        public Double valor { get; set; }
        public String valor_string { get; set; }
        public String tipo { get; set; }
        public String valor_parcela_string { get; set; }
        public String nm_cadastrou { get; set; }
        public String dt_cadastrou { get; set; }
        public String desc_despesa { get; set; }
        public String qtde { get; set; }
        public String retorno { get; set; }


        public Int32 conta_bancaria { get; set; }
        public Int32 id_despesa { get; set; }

        public String ds_banco { get; set; }
        public Int32 id_obra { get; set; }
        public String desc_obra { get; set; }

        public string data { get; set; }
        public int id_fornecedor { get; set; }
        public String desc_fornecedor { get; set; }

        public String nm_usuario { get; set; }

        public List<Contas> listaContas1 { get; set; }
        public List<Contas> listaContas2 { get; set; }

    }
   





    }