using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ContrutoraApp;



public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblusuario.Text = Session["usuario"].ToString();
    }

    protected void consultarUsuario(String nm_usuario)
    {




    }
}

