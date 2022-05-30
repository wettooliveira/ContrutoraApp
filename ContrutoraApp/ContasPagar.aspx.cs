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
                hdnUsuario.Value = Session["nm_login"].ToString();

                txtData.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtParcela.Text = "1";

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
        public static String TabelaContaTemporaria(Contas contas)
        {

            int numero_conta = 0;

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


            //verifica numero da ultima conta gravada
            cmd.CommandText = " Select top 1 num_conta + 1 as num_conta from tb_contasPagar order by 1 desc";

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    numero_conta = Convert.ToInt32(dr["num_conta"]);
                }
            }
            else
            {
                numero_conta = 1;
            }
            dr.Close();
            //fim verifica numero da ultima conta gravada


            int parcelas = Convert.ToInt32(contas.num_parcela_string);

            //valor das parcelas
            Decimal valor_parcelas = 0;
            if (parcelas > 1)
            {
                String valor1 = Convert.ToDecimal(contas.valor_string.Replace('.', ',')).ToString("N2");
                valor_parcelas = Convert.ToDecimal(valor1) / parcelas;
            }
            else
            {
                String valor1 = contas.valor_string.Replace('.', ',').ToString();
                valor_parcelas = Convert.ToDecimal(valor1);
            }


            String table = "";
            String cor_r = "#90EE90";

            table += "      <table id='tbDados1' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";
            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Conta</th>";
            table += "              <th  nowrap scope='col' align='left'  >Descrição</th>";
            table += "              <th  nowrap scope='col' align='left'  >Fornecedor</th>";
            table += "              <th  nowrap scope='col' align='left'  >Obra</th>";
            table += "              <th  nowrap scope='col' style='width:100px'>Form Pgto.</th>";
            table += "              <th  nowrap scope='col' style='width:80px; text-align:left'>Parcela</th>";
            table += "              <th  nowrap scope='col' style='width:100px;text-align:left'>Valor</th>";
            table += "              <th  nowrap scope='col' style='width:80px; text-align:center'>Data Pagto.</th>";
            table += "          </tr> ";

            int contadorData = 0;
            for (int i = 1; i <= parcelas; i++)
            {

                //if (cor_r.Equals("#90EE90")) { cor_r = "#90EE90"; } else { cor_r = "#90EE90"; }
                if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }


                table += "          <tr               style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th style='border-bottom: 1px solid; text-align:left' data-content=" + numero_conta + "> " + numero_conta + " </th>";
                table += "          <th               style='border-bottom: 1px solid'> " + contas.desc_despesa + " </th>";
                table += "          <th               style='border-bottom: 1px solid'>" + contas.desc_fornecedor + "</th>";
                table += "          <th               style='border-bottom: 1px solid'>" + contas.desc_obra + "</th>";
                table += "          <th align='left'  style='border-bottom: 1px solid; width:100px'>" + contas.tipo_pgto + "</th>";
                table += "          <th style='border-bottom: 1px solid; width:80px; text-align:rigth'> " + i.ToString() + "/" + contas.num_parcela_string + " </th>"; //Parcela
                table += "          <th style='border-bottom: 1px solid; width:100px;text-align:rigth'>  <input type='text' id='txtVlParcelaTb_" + i + "'  style='width: 100px; height: 30px' value=" + Convert.ToDouble(valor_parcelas).ToString("N2") + " onKeyPress='return(moeda(this, '.', ',',event))' /> </th>";

                if (contadorData == 0)
                {

                    //table += "          <th align='center' style='border-bottom: 1px solid; width:80px'> "+ Convert.ToDateTime(contas.data).ToString("dd/MM/yyyy") + " </th>";
                    table += "          <th align='center' style='border-bottom: 1px solid; width:80px'>  <input type='text'  id='txtDataTb_" + i + "' style='width: 100px; height: 30px' value=" + Convert.ToDateTime(contas.data).ToString("dd/MM/yyyy") + " /></th>";

                }
                else
                {

                    //table += "          <th align='center' style='border-bottom: 1px solid; width:80px'> " + Convert.ToDateTime(contas.data).AddMonths(contadorData).ToString("dd/MM/yyyy") + " </th>";
                    //table += "          <th align='center' style='border-bottom: 1px solid; width:80px'> " + Convert.ToDateTime(contas.data).ToString("dd/MM/yyyy") + " </th>";
                    table += "          <th align='center' style='border-bottom: 1px solid; width:80px'>  <input type='text' id='txtDataTb_" + i + "'  style='width: 100px; height: 30px' value=" + Convert.ToDateTime(contas.data).AddMonths(contadorData).ToString("dd/MM/yyyy") + " /></th>";
                }


                table += "          </tr> ";

                contadorData++;
            }

            cn.Close();

            table += "          <tr style='color:White;background-color:#5D7B9D;height:10px'> ";
            table += "              <th colspan='8' style='height:10px; color:#5D7B9D'> </th>";
            table += "          </tr> ";
            table += "      </table> ";
            return table;

        }

        [WebMethod]
        public static String TabelaContasPagas(String status)
        {
            String getDataCadastradasInicial = DateTime.Now.ToString("dd-MM-yyyy") + " 00:00:00";
            String getDataCadastradasFinal = DateTime.Now.ToString("dd-MM-yyyy") + " 23:59:00";
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
            cmd.CommandText = @"select cp.id, cp.num_conta, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, cp.tipo_pgto ,cp.parcela as num_parcela, cp.valor_parcela as valor, convert(varchar(30),cp.dt_pagamento,103) as vencimento
                                from tb_contasPagas cp
                                left join tb_despesa desp on desp.id_despesa = cp.id_despesa
                                left join obra obra on obra.id_obra = cp.id_obra
                                LEFT join tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc <> 'cliente'";
            cmd.CommandText += " where dt_pagou >= '" + getDataCadastradasInicial + "' and dt_pagou <= '" + getDataCadastradasFinal + "' order by 1 desc";



            String table = "";

            String cor_r = "#90EE90";

            table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Conta</th>";
            table += "              <th  nowrap scope='col' align='left'   style=''>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left'   style=''>Fornecedor</th>";
            table += "              <th  nowrap scope='col' style='width:100px'>Form Pgto.</th>";
            table += "              <th  nowrap scope='col' style='width:80px; text-align:left'>Parcela</th>";
            table += "              <th  nowrap scope='col' style='width:100px;text-align:left'>Valor</th>";
            table += "              <th  nowrap scope='col' style='width:80px; text-align:center'>Data Pagto.</th>";
            table += "              <th  nowrap scope='col' style='text-align:center;width:80px'> Detalhar  </th>";
            table += "              <th  nowrap scope='col' style='text-align:center;width:80px'> Estornar  </th>";
            table += "          </tr> ";

            cmd.CommandText = cmd.CommandText;

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                while (dr.Read())
                {

                    if (cor_r.Equals("#90EE90")) { cor_r = "#90EE90"; } else { cor_r = "#90EE90"; }


                    table += "          <tr                style='color:Black;background-color:" + cor_r + "'> ";
                    table += "          <th style='border-bottom: 1px solid; text-align:left'> " + dr["num_conta"].ToString() + " </th>";
                    table += "          <th                style='border-bottom: 1px solid'> " + dr["desc_despesa"].ToString().ToUpper() + " </th>";
                    table += "          <th                style='border-bottom: 1px solid'>" + dr["razaoSocial"].ToString() + "</th>";
                    table += "          <th align='left'  style='border-bottom: 1px solid; width:100px'>" + dr["tipo_pgto"].ToString() + "</th>";
                    table += "          <th style='border-bottom: 1px solid; width:80px; text-align:rigth'> " + dr["num_parcela"].ToString() + " </th>";
                    table += "          <th style='border-bottom: 1px solid; width:100px;text-align:rigth'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                    table += "          <th align='center' style='border-bottom: 1px solid; width:80px'> " + dr["vencimento"] + " </th>";
                    table += "          <th  nowrap scope='col' align='center' style='width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["num_conta"].ToString() + "); return false;' />  </th>";
                    table += "          <th  nowrap scope='col' align='center' style='width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-danger' value='Estornar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='estornar(" + dr["id"].ToString() + "); return false;' />  </th>";
                    table += "          </tr> ";

                }

            }
            else
            {
                cor_r = "#fffff";
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th colspan='10'style='border-bottom: 1px solid; height:30px'> Nenhuma informação encontrada. </th>";
                table += "          </tr> ";
            }


            table += "          <tr style='color:White;background-color:#5D7B9D;height:10px'> ";
            table += "              <th colspan='10' style='height:10px; color:#5D7B9D'> </th>";
            table += "          </tr> ";

            dr.Close();
            cn.Close();
            table += "      </table> ";

            return table;

        }

        [WebMethod]
        public static String TabelaContasPagar(String status, String num_conta)
        {
            String getData = DateTime.Now.ToString("dd-MM-yyyy");
            String getDataCadastradasInicial = DateTime.Now.ToString("dd-MM-yyyy") + " 00:00:00";
            String getDataCadastradasFinal = DateTime.Now.ToString("dd-MM-yyyy") + " 23:59:00";
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

            String table = "";


            if (status == "consultar")
            {


                //comando de instrução do banco de dados
                cmd.CommandText = @" select cp.id, cp.num_conta, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, obra.id_obra, cp.tipo_pgto ,cp.parcela as num_parcela, cp.valor_parcela as valor, convert(varchar(30),cp.dt_pagamento,103) as vencimento,  'Não Pagas' as status
                                 from tb_contasPagar cp                             
                                 left join obra obra on obra.id_obra = cp.id_obra
								 left join tb_despesa desp on desp.id_despesa = cp.id_despesa
                                 LEFT join tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc <> 'cliente'	";
                cmd.CommandText += " WHERE  cp.dt_pagamento >= '" + getDataCadastradasInicial + "' and cp.dt_pagamento <= '" + getDataCadastradasFinal + "'";
                //cmd.CommandText += " union";
                //cmd.CommandText += " select p.id, p.num_conta, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, obra.id_obra, p.tipo_pgto ,p.parcela as num_parcela, p.valor_parcela as valor, convert(varchar(30),p.dt_pagamento,103) as vencimento, 'Pagas' as status";
                //cmd.CommandText += " from tb_contasPagas p";
                //cmd.CommandText += " left join obra obra on obra.id_obra = p.id_obra";
                //cmd.CommandText += " left join tb_despesa desp on desp.id_despesa = p.id_despesa";
                //cmd.CommandText += " LEFT join tb_cliente fornec on fornec.id = p.fornec and fornec.tp_cli_fornc <> 'cliente'";
                //cmd.CommandText += " WHERE p.num_conta =" + num_conta;

                String cor_r = "#FFFFFF";

                table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

                table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
                table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Conta</th>";
                table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
                table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Fornecedor</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Form Pgto.</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Parcela</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Valor</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Data Pgto.</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Detalhar  </th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Editar  </th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Excluir </th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Baixar </th>";
                table += "          </tr> ";

                cmd.CommandText = cmd.CommandText;

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {

                    while (dr.Read())
                    {
                        String dataVencimento = DateTime.Now.ToString("dd/MM/yyyy");

                        if ("Pagas" == dr["status"].ToString())
                        {
                            if (cor_r.Equals("#FFFFFF")) { cor_r = "#90EE90"; } else { cor_r = "#90EE90"; }
                        }
                        else
                        {
                            if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
                        }

                        table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                        table += "          <th style='border-bottom: 1px solid #eee; text-align:center'> " + dr["num_conta"].ToString() + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee'> " + dr["desc_despesa"].ToString().ToUpper() + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee;'>" + dr["razaoSocial"].ToString() + "</th>";
                        if (dr["tipo_pgto"].ToString() == "0")
                        {
                            table += "          <th style='border-bottom: 1px solid #eee;'></th>";
                        }
                        else
                        {
                            table += "          <th style='border-bottom: 1px solid #eee;'>" + dr["tipo_pgto"].ToString() + "</th>";
                        }
                       
                        table += "          <th style='border-bottom: 1px solid #eee'> " + dr["num_parcela"].ToString() + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee'> " + dr["vencimento"] + " </th>";
                        table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["num_conta"].ToString() + "); return false;' />  </th>";
                        table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; height:23px; cursor: pointer; text-align:center; padding-top:initial ' onclick='editar(" + dr["id"].ToString() + "); return false;' /> </th>";
                        table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='excluirConta(" + dr["num_conta"].ToString() + "," + dr["id"].ToString() + "); return false;' />  </th>";
                        table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnExcluir'  type='button' class='btn btn-success' value='Baixar' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='baixarConta(" + dr["id"].ToString() + "); return false;' />  </th>";
                        table += "          </tr> ";

                    }

                }
                else
                {
                    table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                    table += "          <th colspan='10'style='border-bottom: 1px solid; height:30px'> Nenhuma informação encontrada. </th>";
                    table += "          </tr> ";
                }

                table += "          <tr style='color:White;background-color:#5D7B9D;height:10px'> ";
                table += "              <th colspan='11' style='height:10px; color:#5D7B9D'> </th>";
                table += "          </tr> ";

                dr.Close();


            }
            else
            {
                //comando de instrução do banco de dados
                cmd.CommandText = @" select cp.id, cp.num_conta, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, obra.id_obra, cp.tipo_pgto ,cp.parcela as num_parcela, cp.valor_parcela as valor, convert(varchar(30),cp.dt_pagamento,103) as vencimento
                                 from tb_contasPagar cp                             
                                 left join obra obra on obra.id_obra = cp.id_obra
								 left join tb_despesa desp on desp.id_despesa = cp.id_despesa
                                 LEFT join tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc <> 'cliente'";
                cmd.CommandText += " WHERE cp.dt_pagamento <= '" + getDataCadastradasFinal + "' ";
                cmd.CommandText += " ORDER BY 1 desc   ";

                String cor_r = "#FFFFFF";

                table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

                table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
                table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Conta</th>";
                table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
                table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Fornecedor</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Form Pgto.</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Parcela</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Valor</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Data Pgto.</th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Detalhar  </th>";
                //table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Editar  </th>";
                //table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Excluir </th>";
                table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Baixar </th>";
                table += "          </tr> ";

                cmd.CommandText = cmd.CommandText;

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {

                    while (dr.Read())
                    {
                        String dataVencimento = DateTime.Now.ToString("dd/MM/yyyy");

                        if (dataVencimento != dr["vencimento"].ToString())
                        {
                            if (cor_r.Equals("#FFFFFF")) { cor_r = "#FF6347"; } else { cor_r = "#FF6347"; }
                        }
                        else
                        {
                            if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
                        }

                        table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                        table += "          <th style='border-bottom: 1px solid #eee; text-align:center'> " + dr["num_conta"].ToString() + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee'> " + dr["desc_despesa"].ToString().ToUpper() + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee;'>" + dr["razaoSocial"].ToString() + "</th>";
                        table += "          <th style='border-bottom: 1px solid #eee;'>" + dr["tipo_pgto"].ToString() + "</th>";
                        table += "          <th style='border-bottom: 1px solid #eee'> " + dr["num_parcela"].ToString() + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                        table += "          <th style='border-bottom: 1px solid #eee'> " + dr["vencimento"] + " </th>";
                        table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["num_conta"].ToString() + "); return false;' />  </th>";
                        //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; height:23px; cursor: pointer; text-align:center; padding-top:initial ' onclick='editar(" + dr["id"].ToString() + "); return false;' /> </th>";
                        //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='excluirConta(" + dr["num_conta"].ToString() + "); return false;' />  </th>";
                        table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnExcluir'  type='button' class='btn btn-success' value='Baixar' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='baixarConta(" + dr["id"].ToString() + "); return false;' />  </th>";
                        table += "          </tr> ";

                    }

                }
                else
                {
                    table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                    table += "          <th colspan='9'style='border-bottom: 1px solid; height:30px'> Nenhuma informação encontrada. </th>";
                    table += "          </tr> ";
                }

                table += "          <tr style='color:White;background-color:#5D7B9D;height:10px'> ";
                table += "              <th colspan='9' style='height:10px; color:#5D7B9D'> </th>";
                table += "          </tr> ";

                dr.Close();
            }




            cn.Close();

            table += "      </table> ";

            return table;

        }

        //[WebMethod]
        //public static String TabelaContasPagas(String status)
        //{

        //    //// Passa o caminho do banco de dados para um string      
        //    string connectionString = Conexao.StrConexao;

        //    //chama o metodo de conexao com o banco
        //    SqlConnection cn = new SqlConnection();
        //    cn.ConnectionString = connectionString;

        //    //construtor command para obter dados44
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = cn;
        //    //abre a conexao
        //    cn.Open();

        //    //comando de instrução do banco de dados
        //    cmd.CommandText = @"select cp.id, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, cp.tipo_pgto ,cp.num_parcela, cp.valor, convert(varchar(30),cp.dt_pagamento,103) as vencimento from tb_contasPagar cp
        //                       inner join tb_despesa desp on desp.id_despesa = cp.id_despesa
        //                       left join obra obra on obra.id_obra = cp.id_obra
        //                       LEFT join tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc = 'fornecedor' WHERE cp.status = 'pago' order by 1 desc";


        //    String table = "";

        //    String cor_r = "#90EE90";

        //    table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

        //    table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
        //    table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
        //    table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Fornecedor</th>";
        //    table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Form Pgto.</th>";
        //    table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Parcela</th>";
        //    table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Valor</th>";
        //    table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Data Pagto.</th>";
        //    table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Detalhar  </th>";
        //    table += "          </tr> ";

        //    cmd.CommandText = cmd.CommandText;

        //    SqlDataReader dr = cmd.ExecuteReader();
        //    if (dr.HasRows)
        //    {

        //        while (dr.Read())
        //        {

        //            if (cor_r.Equals("#90EE90")) { cor_r = "#90EE90"; } else { cor_r = "#90EE90"; }


        //            table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
        //            table += "          <th style='border-bottom: 1px solid; height:30px'> " + dr["desc_despesa"].ToString().ToUpper() + " </th>";
        //            table += "          <th style='border-bottom: 1px solid;'>" + dr["razaoSocial"].ToString() + "</th>";
        //            table += "          <th style='border-bottom: 1px solid;'>" + dr["tipo_pgto"].ToString() + "</th>";
        //            table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["num_parcela"]).ToString() + " </th>";
        //            table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
        //            table += "          <th style='border-bottom: 1px solid'> " + dr["vencimento"] + " </th>";
        //            table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
        //            table += "          </tr> ";

        //        }

        //    }
        //    else
        //    {
        //        table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
        //        table += "          <th colspan='10'style='border-bottom: 1px solid; height:30px'> Nenhuma informação encontrada. </th>";
        //        table += "          </tr> ";
        //    }

        //    dr.Close();
        //    cn.Close();
        //    table += "      </table> ";

        //    return table;

        //}

        [WebMethod]
        public static String TabelaTempDetalhesContas()
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
            cmd.CommandText = @"select  id, desc_detalhe, qtde, valor, nf from tb_temp_detalhes_contasPagar";


            String table = "";


            table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            String cor_r = "#FFFFFF";
            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>qtde</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>vlr unit</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>nf</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Excluir </th>";
            table += "          </tr> ";

            cmd.CommandText = cmd.CommandText;

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th style='border-bottom: 1px solid; height:30px'> " + dr["desc_detalhe"].ToString() + " </th>";
                table += "          <th style='border-bottom: 1px solid;'>" + dr["qtde"].ToString() + "</th>";
                table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                table += "          <th style='border-bottom: 1px solid;'>" + dr["nf"].ToString() + "</th>";
                //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
                //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; height:23px; cursor: pointer; text-align:center; padding-top:initial ' /> </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' /> </th>";
                table += "          </tr> ";


            }

            dr.Close();
            cn.Close();
            table += "      </table> ";

            return table;

        }

        [WebMethod]
        public static String BuscarTabelaDetalhesContas(String id)
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
            cmd.CommandText = @"select  id, desc_detalhe, qtde, valor, nf from tb_detalhes_contasPagar where num_conta =" + id;


            String table = "";
            String nf = "";


            table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            String cor_r = "#FFFFFF";
            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>qtde</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>vlr unit</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>nf</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Excluir </th>";
            table += "          </tr> ";

            cmd.CommandText = cmd.CommandText;

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th style='border-bottom: 1px solid; height:30px'> " + dr["desc_detalhe"].ToString() + " </th>";
                table += "          <th style='border-bottom: 1px solid;'>" + dr["qtde"].ToString() + "</th>";
                table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                table += "          <th style='border-bottom: 1px solid;'>" + dr["nf"].ToString() + "</th>";
                //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
                //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; height:23px; cursor: pointer; text-align:center; padding-top:initial ' /> </th>";
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='ExcluirItemDetalhadoConta(" + dr["id"].ToString() + "); return false;' /> </th>";
                table += "          </tr> ";

                nf = dr["nf"].ToString();
            }

            dr.Close();
            cn.Close();
            table += "      </table> ";

            return table + "@" + nf;

        }

        [WebMethod]
        public static String DeletarTabelaTempDetalhes()
        {
            Dao dao = new Dao();

            return dao.DeletarTabelaTemporariaDetalhes();
        }

        [WebMethod]
        public static String Gravar_old(Contas Contas)
        {
            // ---------------------------- Colocar trava de valor maior da parcela do que o valor total -----------------------------------------------
           


            // Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            // chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            cmd.CommandText = cmd.CommandText;

            // abre a conexao
            cn.Open();
                        

            foreach (Contas c in Contas.listaContas1)
            {
                cmd.Parameters.Clear();
                cmd.CommandText = @"INSERT INTO tb_contasPagar(num_conta,valor_parcela ,parcela,num_parcela, tipo_pgto ,valor, id_despesa, fornec, id_conta_bancaria, id_obra, dt_pagamento, nm_cadastrou,dt_cadastrou)
                                values(@num_conta, @valor_parcela,@parcela,@num_parcela, @tipo_pgto, @valor, @id_despesa ,@fornec, @id_conta_bancaria, @id_obra, @dt_pagamento,@nm_cadastrou,getdate())";

                cmd.Parameters.AddWithValue("@num_conta", Convert.ToInt32(c.num_conta));
                cmd.Parameters.AddWithValue("@valor_parcela", c.valor_parcela_string);
                cmd.Parameters.AddWithValue("@parcela", c.num_parcela_string.Trim());
                cmd.Parameters.AddWithValue("@num_parcela", Convert.ToInt32(c.num_parcela_string.Split('/')[1]));
                cmd.Parameters.AddWithValue("@tipo_pgto", c.tipo_pgto);
                cmd.Parameters.AddWithValue("@valor", c.valor_string);
                if (c.id_despesa == 0)
                {
                    cmd.Parameters.AddWithValue("@id_despesa", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@id_despesa", Convert.ToInt32(c.id_despesa));
                }
                cmd.Parameters.AddWithValue("@fornec", Convert.ToInt32(c.id_fornecedor));
                cmd.Parameters.AddWithValue("@dt_pagamento", Convert.ToDateTime(c.data));
                cmd.Parameters.AddWithValue("@id_conta_bancaria", Convert.ToInt32(c.conta_bancaria));
                if (c.id_obra == 0)
                {
                    cmd.Parameters.AddWithValue("@id_obra", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@id_obra", Convert.ToInt32(c.id_obra));
                }
                cmd.Parameters.AddWithValue("@nm_cadastrou", c.nm_usuario);

                cmd.ExecuteNonQuery();

            }

            cn.Close();

            return "OK";

        }

        [WebMethod]
        public static String Gravar(Contas Contas)
        {
            string data = DateTime.Now.AddMonths(8).ToString("dd/MM/yyyy");
            int numero_conta = 0;
            // Passa o caminho do banco de dados para um string      
            string connectionString = Conexao.StrConexao;

            // chama o metodo de conexao com o banco
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = connectionString;

            //construtor command para obter dados44
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            cmd.CommandText = cmd.CommandText;

            // abre a conexao
            cn.Open();

            cmd.CommandText = " Select top 1 num_conta + 1 as num_conta from tb_contasPagar order by 1 desc";

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    numero_conta = Convert.ToInt32(dr["num_conta"]);
                }
            }
            else
            {
                numero_conta = 1;
            }
            dr.Close();

            int parcelas = Convert.ToInt32(Contas.num_parcela_string);
            Decimal valor_parcelas = 0;
            //valor das parcelas

            if (parcelas > 1)
            {
                String valor1 = Convert.ToDecimal(Contas.valor_string.Replace('.', ',')).ToString("N2");
                valor_parcelas = Convert.ToDecimal(valor1) / parcelas;
            }
            else
            {
                String valor1 = Contas.valor_string.Replace('.', ',').ToString();
                valor_parcelas = Convert.ToDecimal(valor1);
            }

            int contadorData = 0;
            for (int i = 1; i <= parcelas; i++)
            {

                //comando de instrução do banco de dados
                cmd.Parameters.Clear();
                cmd.CommandText = @"INSERT INTO tb_contasPagar(num_conta,valor_parcela ,parcela,num_parcela, tipo_pgto ,valor, id_despesa, fornec, id_conta_bancaria, id_obra, dt_pagamento, nm_cadastrou,dt_cadastrou)
                                values(@num_conta, @valor_parcela,@parcela,@num_parcela, @tipo_pgto, @valor, @id_despesa ,@fornec, @id_conta_bancaria, @id_obra, @dt_pagamento,@nm_cadastrou,getdate())";


                cmd.Parameters.AddWithValue("@num_conta", numero_conta);
                cmd.Parameters.AddWithValue("@valor_parcela", valor_parcelas);
                cmd.Parameters.AddWithValue("@parcela", (i.ToString() + "/" + Contas.num_parcela_string).ToString());
                cmd.Parameters.AddWithValue("@num_parcela", Convert.ToInt32(Contas.num_parcela_string));
                cmd.Parameters.AddWithValue("@tipo_pgto", Contas.tipo_pgto);
                cmd.Parameters.AddWithValue("@valor", Contas.valor_string);
                if (Contas.id_despesa == 0)
                {
                    cmd.Parameters.AddWithValue("@id_despesa", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@id_despesa", Convert.ToInt32(Contas.id_despesa));
                }

                if (contadorData == 0)
                {
                    cmd.Parameters.AddWithValue("@dt_pagamento", Convert.ToDateTime(Contas.data));
                }
                else
                {
                    cmd.Parameters.AddWithValue("@dt_pagamento", Convert.ToDateTime(Contas.data).AddMonths(contadorData));
                }

                cmd.Parameters.AddWithValue("@fornec", Convert.ToInt32(Contas.id_fornecedor));
                cmd.Parameters.AddWithValue("@id_conta_bancaria", Convert.ToInt32(Contas.conta_bancaria));
                if (Contas.id_obra == 0)
                {
                    cmd.Parameters.AddWithValue("@id_obra", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@id_obra", Convert.ToInt32(Contas.id_obra));
                }

                cmd.Parameters.AddWithValue("@nm_cadastrou", Contas.nm_usuario);

                cmd.ExecuteNonQuery();
                contadorData++;
            }

            cn.Close();

            return "OK";

        }

        [WebMethod]
        public static String Alterar(Contas Contas)
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
            cmd.CommandText = @"UPDATE [dbo].[tb_contasPagar]
                                                             SET num_parcela = @num_parcela,
                                                                 tipo_pgto = @tipo_pgto,
                                                                 valor = @valor,
                                                                 dt_pagamento = @dt_pagamento,
                                                                 id_despesa = @id_despesa,
                                                                 id_obra = @id_obra,
                                                                 fornec = @fornec, 
                                                                 id_conta_bancaria = @id_conta_bancaria,   
                                                                 dt_alterou = @dt_alterou
                                                                 WHERE [id] = @id ";


            cmd.Parameters.AddWithValue("@id", Contas.id);
            cmd.Parameters.AddWithValue("@num_parcela", Contas.num_parcela_string);
            cmd.Parameters.AddWithValue("@tipo_pgto", Contas.tipo_pgto);
            cmd.Parameters.AddWithValue("@valor", Contas.valor_string);
            cmd.Parameters.AddWithValue("@dt_pagamento", Convert.ToDateTime(Contas.data));
            cmd.Parameters.AddWithValue("@fornec", Contas.id_fornecedor);
            cmd.Parameters.AddWithValue("@id_despesa", Contas.id_despesa);
            cmd.Parameters.AddWithValue("@id_conta_bancaria", Contas.conta_bancaria);
            cmd.Parameters.AddWithValue("@id_obra", Contas.id_obra);
            cmd.Parameters.AddWithValue("@dt_alterou", DateTime.Now);

            cmd.ExecuteNonQuery();
            cn.Close();

            return "OK";

        }

        [WebMethod]
        public static String ExcluirConta(String id, String acao)
        {

            String retorno = "";
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

            if (acao == "Todas")
            {
                //regra se tiver conta paga tem que estornar

                cmd.CommandText = @"select * from tb_contasPagas where num_conta =" + id;

                SqlDataReader dr = cmd.ExecuteReader();

                bool tem_parcela_paga = false;
                if (dr.HasRows)
                {
                    tem_parcela_paga = true;
                }

                dr.Close();

                if (!tem_parcela_paga)
                {
                    //comando de instrução do banco de dados
                    cmd.Parameters.Clear();
                    cmd.CommandText = @"delete tb_contasPagar where num_conta = " + id;
                    cmd.ExecuteNonQuery();

                    //comando de instrução do banco de dados
                    cmd.CommandText = @"delete tb_detalhes_contasPagar where num_conta = " + id;
                    cmd.ExecuteNonQuery();

                    retorno = "OK";
                }
                else
                {
                    retorno = "existe parcela";
                }

            }
            else
            {
                // regras se for 1 conta só excluir dos detalhes                
                cmd.CommandText = @"SELECT * FROM tb_contasPagar pagar
                                    INNER JOIN tb_contasPagas pagas on pagas.num_conta = pagar.num_conta
                                    WHERE pagar.id =" + id;

                SqlDataReader dr = cmd.ExecuteReader();

                Boolean tem_parcela_paga = false;
                if (dr.HasRows)
                {
                    tem_parcela_paga = true;
                }

                dr.Close();
                if (!tem_parcela_paga)
                {
                    //comando de instrução do banco de dados
                    cmd.CommandText = @"delete tb_contasPagar WHERE id = " + id;
                    cmd.ExecuteNonQuery();
                }
                else
                {

                }

                retorno = "OK";
            }


            cn.Close();
            return retorno;

        }

        //[WebMethod]
        //public static String EditarConta(String id)
        //{
        //    //// Passa o caminho do banco de dados para um string      
        //    string connectionString = Conexao.StrConexao;

        //    //chama o metodo de conexao com o banco
        //    SqlConnection cn = new SqlConnection();
        //    cn.ConnectionString = connectionString;

        //    //construtor command para obter dados44
        //    SqlCommand cmd = new SqlCommand();
        //    cmd.Connection = cn;
        //    cmd.CommandText = cmd.CommandText;

        //    //abre a conexao
        //    cn.Open();

        //    //comando de instrução do banco de dados
        //    cmd.CommandText = @"tb_contasPagar where id = " + id;
        //    cmd.ExecuteNonQuery();

        //    //comando de instrução do banco de dados
        //    cmd.CommandText = @"delete tb_detalhes_contasPagar where id_conta = " + id;
        //    cmd.ExecuteNonQuery();

        //    cn.Close();
        //    return "OK";

        //}

        [WebMethod]
        public static String BaixarConta(String id, String usuario)
        {
            String retorno = "";

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


            try
            {
                cmd.CommandText = @"insert into tb_contasPagas(	

                                                            num_conta,
                                                        	parcela,
                                                        	num_parcela,
                                                        	tipo_pgto,
                                                        	valor_parcela,
                                                        	valor,
                                                        	id_despesa,
                                                        	id_obra,
                                                        	fornec,
                                                        	dt_pagamento,	
                                                        	id_conta_bancaria,
                                                        	nm_cadastrou,
                                                        	dt_cadastrou,
                                                        	dt_alterou,
                                                        	nm_pagou, dt_pagou
                                                        )
                                                        SELECT
                                                              [num_conta]
                                                              ,[parcela]
                                                              ,[num_parcela]
                                                              ,[tipo_pgto]
                                                              ,[valor_parcela]
                                                              ,[valor]
                                                              ,[id_despesa]
                                                              ,[id_obra]
                                                              ,[fornec]
                                                              ,[dt_pagamento]
                                                              ,[id_conta_bancaria]
                                                              ,[nm_cadastrou]
                                                              ,[dt_cadastrou]
                                                              ,[dt_alterou]
                                                        	  ,@nm_pagou, @dt_pagou
                                                          FROM tb_contasPagar where id =  @id";

                cmd.Parameters.AddWithValue("@nm_pagou", usuario);
                cmd.Parameters.AddWithValue("@dt_pagou", DateTime.Now);
                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();

                //comando de instrução do banco de dados
                cmd.Parameters.Clear();
                cmd.CommandText = @"delete tb_contasPagar where id = " + id;
                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();

                retorno = "OK";
                cn.Close();
            }
            catch (Exception ex)
            {
                retorno = "ERRO";
                cn.Close();
            }



            return retorno;

        }

        [WebMethod]
        public static String EstornaConta(String id)
        {
            String retorno = "";

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


            try
            {
                cmd.CommandText = @"insert into tb_contasPagar(	num_conta,valor_parcela, parcela,num_parcela, tipo_pgto ,valor, id_despesa, fornec, id_conta_bancaria, id_obra, 
                                                                dt_pagamento, nm_cadastrou,dt_cadastrou )
                                                        SELECT
                                                            num_conta,
                                                            valor_parcela,
                                                        	parcela,
                                                        	num_parcela,
                                                        	tipo_pgto,                                                        	
                                                        	valor,
                                                        	id_despesa,
                                                            fornec,
                                                            id_conta_bancaria,
                                                        	id_obra,                                                        	
                                                        	dt_pagamento,                                                        	
                                                        	nm_cadastrou,
                                                        	dt_cadastrou                                                        	    
                                                         FROM tb_contasPagas WHERE id =  @id";


                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();

                //comando de instrução do banco de dados
                cmd.Parameters.Clear();
                cmd.CommandText = @"delete tb_contasPagas where id = " + id;
                cmd.Parameters.AddWithValue("@id", id);

                cmd.ExecuteNonQuery();

                retorno = "OK";
                cn.Close();
            }
            catch (Exception ex)
            {
                retorno = "ERRO";
                cn.Close();
            }



            return retorno;

        }

        [WebMethod]
        public static String GravarDetalhes(Contas Contas)
        {
            String retorno = "";
            Contas DadosDetalhes = new Contas();
            Dao GravarTempDetalhesmodal = new Dao();
            Dao buscarTempDetalhesmodal = new Dao();

            retorno = GravarTempDetalhesmodal.GravarDetalhesDao(Contas);
            DadosDetalhes.retorno = retorno;
            //if (retorno == "OK")
            //{
            //    DadosDetalhes = buscarTempDetalhesmodal.BuscarDadosDetalhesModal(Contas, "gravar");
            //}

            //DadosDetalhes = buscarTempDetalhesmodal.BuscarDadosDetalhesModal(Contas,"buscar");

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

        public void CarregaDespesa()
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

            cmd.CommandText = @"SELECT * FROM tb_despesa ORDER BY 2 ";

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

        [WebMethod]
        public static Contas EditarContaPagar(String id)
        {
            String getData = DateTime.Now.ToString("dd-MM-yyyy");
            Contas c = new Contas();
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
            cmd.CommandText = @" SELECT cp.id, cp.num_conta,isnull(desp.id_despesa,0) as id_despesa , fornec.razaoSocial, isnull(fornec.id,0) as id_fornec, obra.desc_obra, isnull(obra.id_obra,0) id_obra, cp.tipo_pgto ,cp.num_parcela, cp.valor, convert(varchar(30),cp.dt_pagamento,103) as vencimento, cp.id_conta_bancaria, conta.ds_agencia +' - '+ ds_conta +' '+ ds_banco as banco
                                 FROM tb_contasPagar cp
                                 LEFT JOIN tb_despesa desp on desp.id_despesa = cp.id_despesa
                                 LEFT JOIN obra obra on obra.id_obra = cp.id_obra
                                 LEFT JOIN tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc = 'fornecedor'
                                 INNER JOIN tb_conta conta on conta.id = cp.id_conta_bancaria 
                                 INNER JOIN tb_bancos banco on banco.id = conta.id_banco";
            cmd.CommandText += " WHERE cp.status is null and cp.id = " + id;


            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                c.id = Convert.ToInt32(dr["id"]);
                c.num_conta = Convert.ToInt32(dr["num_conta"]);
                c.conta_bancaria = Convert.ToInt32(dr["id_conta_bancaria"]);
                c.ds_banco = dr["banco"].ToString();
                c.id_despesa = Convert.ToInt32(dr["id_despesa"]);
                c.id_fornecedor = Convert.ToInt32(dr["id_fornec"]);
                c.desc_fornecedor = dr["razaoSocial"].ToString();

                c.id_obra = Convert.ToInt32(dr["id_obra"]);
                c.desc_obra = dr["desc_obra"].ToString();
                c.tipo_pgto = dr["tipo_pgto"].ToString();
                c.num_parcela = Convert.ToInt32(dr["num_parcela"]);
                c.data = dr["vencimento"].ToString();
                c.valor_string = Convert.ToDecimal(dr["valor"]).ToString("N2");
            }

            dr.Close();
            cn.Close();

            return c;
        }


        [WebMethod]
        public static String ExcluirItemDetalhadoConta(String id)
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
            cmd.CommandText = @"delete tb_detalhes_contasPagar where id = " + id;
            cmd.ExecuteNonQuery();

            cn.Close();
            return "OK";

        }


    }
}