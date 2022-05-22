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
    public partial class consultar_ContasPagar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static String TabelaContasPagar(String NumeroConta)
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

            String numero_conta = "";
            String table = "";


            //comando de instrução do banco de dados
            cmd.CommandText = @" select cp.id, cp.num_conta, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, obra.id_obra, cp.tipo_pgto ,cp.parcela as num_parcela, cp.valor_parcela as valor, convert(varchar(30),cp.dt_pagamento,103) as vencimento,  'Não Pagas' as status
                                 from tb_contasPagar cp                             
                                 left join obra obra on obra.id_obra = cp.id_obra
								 left join tb_despesa desp on desp.id_despesa = cp.id_despesa
                                 LEFT join tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc <> 'cliente'	";
            cmd.CommandText += " WHERE cp.num_conta = " + NumeroConta;
            cmd.CommandText += " union";
            cmd.CommandText += " select p.id, p.num_conta, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, obra.id_obra, p.tipo_pgto ,p.parcela as num_parcela, p.valor_parcela as valor, convert(varchar(30),p.dt_pagamento,103) as vencimento, 'Pagas' as status";
            cmd.CommandText += " from tb_contasPagas p";
            cmd.CommandText += " left join obra obra on obra.id_obra = p.id_obra";
            cmd.CommandText += " left join tb_despesa desp on desp.id_despesa = p.id_despesa";
            cmd.CommandText += " LEFT join tb_cliente fornec on fornec.id = p.fornec and fornec.tp_cli_fornc <> 'cliente'";
            cmd.CommandText += " WHERE p.num_conta =" + NumeroConta;


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
            //table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Detalhar  </th>";
            //table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Editar  </th>";
            //table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Excluir </th>";
            //table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;text-align:center'> Baixar </th>";
            table += "          </tr> ";

            cmd.CommandText = cmd.CommandText;

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                while (dr.Read())
                {
                    //String dataVencimento = DateTime.Now.ToString("dd/MM/yyyy");

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
                    table += "          <th style='border-bottom: 1px solid #eee;'>" + dr["tipo_pgto"].ToString() + "</th>";
                    table += "          <th style='border-bottom: 1px solid #eee'> " + dr["num_parcela"].ToString() + " </th>";
                    table += "          <th style='border-bottom: 1px solid #eee'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                    table += "          <th style='border-bottom: 1px solid #eee'> " + dr["vencimento"] + " </th>";
                    //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["num_conta"].ToString() + "); return false;' />  </th>";
                    //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; height:23px; cursor: pointer; text-align:center; padding-top:initial ' onclick='editar(" + dr["id"].ToString() + "); return false;' /> </th>";
                    //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='excluirConta(" + dr["num_conta"].ToString() + "); return false;' />  </th>";
                    //table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid #eee'> <input id='btnExcluir'  type='button' class='btn btn-success' value='Baixar' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='baixarConta(" + dr["id"].ToString() + "); return false;' />  </th>";
                    table += "          </tr> ";

                    numero_conta = dr["num_conta"].ToString();
                }

            }
            else
            {
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th colspan='7'style='border-bottom: 1px solid; height:30px'> Nenhuma informação encontrada. </th>";
                table += "          </tr> ";
            }

            table += "          <tr style='color:White;background-color:#5D7B9D;height:10px'> ";
            table += "              <th colspan='7' style='height:10px; color:#5D7B9D'> </th>";
            table += "          </tr> ";

            dr.Close();




            cn.Close();

            table += "      </table> ";

            return table + "@" + numero_conta;

        }
    }
}