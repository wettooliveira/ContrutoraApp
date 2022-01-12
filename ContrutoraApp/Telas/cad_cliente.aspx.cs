using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ContrutoraApp
{
    public partial class cad_cliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static Endereco BuscarCEP(String cep)
        {
            BuscaAPI buscarcep = new BuscaAPI();
            Endereco end = new Endereco();
            end = buscarcep.BuscaCEP(cep);

            return end;

        }
    }
}