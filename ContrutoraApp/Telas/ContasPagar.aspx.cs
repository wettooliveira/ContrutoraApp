using Newtonsoft.Json;
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
                CarregaDespesa();
                CarregaContasBancos();
              
                txtData.Text = DateTime.Now.ToString("dd/MM/yyyy");
            }
            else
            {
                
            }
        }

        [WebMethod]
        public static String Menu(String m)
        {
            Dao menu = new Dao();

            return menu.Menu();

        }

        [WebMethod]
        public static String TabelaContasPagar()
        {

            //// Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            //chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            //abre a conexao
            cn.Open();

            //comando de instrução do banco de dados
            cmd.CommandText = @"select cp.id, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, cp.num_parcela, cp.valor from tb_contasPagar cp
                               inner join tb_despesa desp on desp.id_despesa = cp.id_despesa
                               inner join obra obra on obra.id_obra = cp.id_obra
                               inner join tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc = 'fornecedor'";


            String table = "";


            table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            String cor_r = "#FFFFFF";
            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Fornecedor</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Parcela</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Valor</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Detalhar  </th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Editar  </th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Excluir </th>";
            table += "          </tr> ";

            cmd.CommandText = cmd.CommandText;

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th style='border-bottom: 1px solid; height:30px'> " + dr["desc_despesa"].ToString() + " </th>";
                table += "          <th style='border-bottom: 1px solid;'>" + dr["razaoSocial"].ToString() + "</th>";
                table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["num_parcela"]).ToString() + " </th>";
                table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; height:23px; cursor: pointer; text-align:center; padding-top:initial ' /> </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' /> </th>";
                table += "          </tr> ";


            }

            dr.Close();

            table += "      </table> ";

            return table;

        }

        [WebMethod] 
        public static String DeletarTabelaTempDetalhes()
        {
            Dao dao = new Dao();

            return dao.DeletarTabelaTemporariaDetalhes();
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
            cmd.CommandText = @"INSERT INTO tb_contasPagar(num_parcela,valor, id_despesa, fornec, id_obra, dt_pagamento, nm_cadastrou,dt_cadastrou)
                                values(@num_parcela,@valor, @id_despesa ,@fornec, @id_obra, @dt_pagamento,'SISTEMA',getdate())";

                   
            cmd.Parameters.AddWithValue("@num_parcela", Contas.num_parcela_string);
            cmd.Parameters.AddWithValue("@valor", Contas.valor_string);
            cmd.Parameters.AddWithValue("@dt_pagamento", Convert.ToDateTime(Contas.data));
            cmd.Parameters.AddWithValue("@fornec", Contas.id_fornecedor);
            cmd.Parameters.AddWithValue("@id_despesa", Contas.id_despesa);       
            cmd.Parameters.AddWithValue("@id_obra", Contas.id_obra);                              

            cmd.ExecuteNonQuery();
            cn.Close();

            return "OK";

        }

        [WebMethod]
        public static String GravarTempDetalhes(Contas Contas)
        {
            String retorno = "";
            Contas DadosDetalhes = new Contas();
            Dao GravarTempDetalhesmodal = new Dao();
            Dao buscarTempDetalhesmodal = new Dao();

            if (Contas.desc_conta != "vazio")
            {
                retorno = GravarTempDetalhesmodal.GravarTempDetalhesDao(Contas);

                if (retorno == "OK")
                {
                    //DadosDetalhes = buscarTempDetalhesmodal.BuscarDadosDetalhesModal(Contas, "gravar");
                }
            }
            else
            {

                //DadosDetalhes = buscarTempDetalhesmodal.BuscarDadosDetalhesModal(Contas,"buscar");

            }

            return JsonConvert.SerializeObject(DadosDetalhes); 
        }

        [WebMethod]
        public static String GravarTabelaDetalhes(String id_conta)
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

            cmd.CommandText = @"delete tb_detalhes_contasPagar where id_conta =" + id_conta;

            cmd.ExecuteNonQuery();

            cmd.Parameters.Clear();
            //comando de instrução do banco de dados
            cmd.CommandText = @"insert into tb_detalhes_contasPagar(desc_detalhe, id_conta, qtde, valor, nf)
                                SELECT desc_detalhe, id_conta, qtde, valor , nf from tb_temp_detalhes_contasPagar where id_conta =" + id_conta;

            cmd.ExecuteNonQuery();

            cmd.Parameters.Clear();
            cmd.CommandText = @"delete tb_temp_detalhes_contasPagar where id_conta =" + id_conta;

            cmd.ExecuteNonQuery();
            cn.Close();

            return "OK";

        }
               
        public void  CarregaDespesa()
        {
            //// Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            //chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
                                  
            //abre a conexao
            cn.Open();

            cmd.CommandText = @"SELECT * FROM tb_despesa ORDER BY 2 DESC";

            SqlDataReader dr = cmd.ExecuteReader();

            List<Despesa> lista = new List<Despesa>();
            while (dr.Read())
            {
                Despesa desp = new Despesa();
                desp.id_despesa = Convert.ToInt32(dr["id_despesa"]);
                desp.desc_despesa = dr["desc_despesa"].ToString().ToUpper();
                lista.Add(desp);
            }

            dr.Close();
            cn.Close();

            ddlDespesa.DataSource = lista;
            ddlDespesa.DataTextField = "desc_despesa";
            ddlDespesa.DataValueField = "id_despesa";
            ddlDespesa.DataBind();
            ddlDespesa.Items.Add(new ListItem("Selecione...", "0"));
            ddlDespesa.SelectedValue = "0";
           

        }

        public void CarregaContasBancos()
        {
            //// Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            //chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;

            //abre a conexao
            cn.Open();

            cmd.CommandText = @"select c.id ,ds_agencia + ' - ' + ds_conta  + ' ' + b.ds_banco   as conta from tb_conta c
                                inner join tb_bancos b on b.id = c.id_banco";

            SqlDataReader dr = cmd.ExecuteReader();

            List<Despesa> lista = new List<Despesa>();
            while (dr.Read())
            {
                Despesa desp = new Despesa();
                desp.id_despesa = Convert.ToInt32(dr["id"]);
                desp.desc_despesa = dr["conta"].ToString();
                lista.Add(desp);
            }

            dr.Close();
            cn.Close();

            ddlConta.DataSource = lista;
            ddlConta.DataTextField = "desc_despesa";
            ddlConta.DataValueField = "id_despesa";
            ddlConta.DataBind();
            //ddlConta.Items.Add(new ListItem("Selecione...", "0"));
            


        }

        public void CarregaObras()
        {
            //// Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            //chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;

            //abre a conexao
            cn.Open();

            cmd.CommandText = @"select c.id ,ds_agencia + ' - ' + ds_conta  + ' ' + b.ds_banco   as conta from tb_conta c
                                inner join tb_bancos b on b.id = c.id_banco";

            SqlDataReader dr = cmd.ExecuteReader();

            List<Despesa> lista = new List<Despesa>();
            while (dr.Read())
            {
                Despesa desp = new Despesa();
                desp.id_despesa = Convert.ToInt32(dr["id"]);
                desp.desc_despesa = dr["conta"].ToString();
                lista.Add(desp);
            }

            dr.Close();
            cn.Close();

            ddlConta.DataSource = lista;
            ddlConta.DataTextField = "desc_despesa";
            ddlConta.DataValueField = "id_despesa";
            ddlConta.DataBind();
            //ddlConta.Items.Add(new ListItem("Selecione...", "0"));



        }

        [WebMethod]
        public static Cliente ConsultarFornecedor(String id)
        {
            Cliente getCliente = new Cliente();
            Dao consultarCliente = new Dao();
            getCliente = consultarCliente.ConsultarFornecedor(id);
            return getCliente;
        }


    }
}