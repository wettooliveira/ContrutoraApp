using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ContrutoraApp
{
    public partial class ContasPagar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

          
            if (!IsPostBack)
            {
               
            }
            else
            {
                
            }
        }
        [WebMethod]
        public static String TabelaContasPagar(String id_receb_new)
        {

            //// Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            //chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;

            //comando de instrução do banco de dados
            cmd.CommandText = "select desc_conta, tipo, num_parcela,valor from tb_contasPagar";
            
            


            String table = "";
                     

            table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            String cor_r = "#FFFFFF";
            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:bold;'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Tipo</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Parcela</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Valor</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Editar  </th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Excluir </th>";
            table += "          </tr> ";

            cmd.CommandText = cmd.CommandText;
            //abre a conexao
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                
                if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th> " + dr["desc_conta"].ToString() + " </th>";
                table += "          <th> " + dr["tipo"].ToString() + " </th>";
                table += "          <th> " + Convert.ToDouble(dr["num_parcela"]).ToString() + " </th>";
                table += "          <th> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnEditar' class='btn btn-info' value='Editar' style='width:80px; cursor: pointer; text-align:center' /> </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center'> <input id='btnExcluir' class='btn btn-danger' value='Excluir' style='width:80px; cursor: pointer;text-align:center' /> </th>";
                table += "          </tr> "; 

            }

            dr.Close();

            table += "      </table> ";

            return table;

        }

        [WebMethod]
        public static String Gravar(Contas Contas)
        {
            //// Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            //chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            cmd.CommandText = cmd.CommandText;

            //abre a conexao
            cn.Open();

            //comando de instrução do banco de dados
            cmd.CommandText = @"INSERT INTO tb_contasPagar(desc_conta,tipo,num_parcela,valor,nm_cadastrou,dt_cadastrou)
                                values(@desc_conta,@tipo,@num_parcela,@valor,'SISTEMA',getdate())";

            cmd.Parameters.AddWithValue("@desc_conta",Contas.desc_conta);
            cmd.Parameters.AddWithValue("@tipo", Contas.tipo);
            cmd.Parameters.AddWithValue("@num_parcela", Contas.num_parcela_string);
            cmd.Parameters.AddWithValue("@valor", Contas.valor_string);

            cmd.ExecuteNonQuery();
            cn.Close();
                   

            return "OK";

        }
    }
}