﻿using Newtonsoft.Json;
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
    public partial class ContasReceber : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CarregaDespesa();
                CarregaContasBancos();

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
        public static String TabelaContasReceber(String status)
        {
            String getData = DateTime.Now.ToString("dd-MM-yyyy");
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
            cmd.CommandText = @" SELECT cp.id, fornec.razaoSocial, obra.desc_obra, cp.tipo_pgto ,cp.num_parcela, cp.valor, convert(varchar(30),cp.dt_pagamento,103) as recebimento
                                 FROM tb_contasReceber cp                                
                                 LEFT JOIN obra obra on obra.id_obra = cp.id_obra
                                 LEFT JOIN tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc = 'cliente'";
            cmd.CommandText += " WHERE cp.status is null and cp.dt_pagamento <= '" + getData + "'";
            cmd.CommandText += " ORDER BY 1 DESC  ";



            String table = "";

            String cor_r = "#FFFFFF";

            table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left' style='padding-right: 20px;'>Fornecedor</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Form Pgto.</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Parcela</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Valor</th>";
            table += "              <th  nowrap scope='col' align='right' style='padding-right: 20px;'>Data Pagto.</th>";
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

                    if (dataVencimento != dr["vencimento"].ToString())
                    {                      
                        if (cor_r.Equals("#FFFFFF")) { cor_r = "#FF6347"; } else { cor_r = "#FF6347"; }
                    }
                    else
                    {
                        if (cor_r.Equals("#FFFFFF")) { cor_r = "#F7F6F3"; } else { cor_r = "#FFFFFF"; }                        
                    }
                  
                    table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                    table += "          <th style='border-bottom: 1px solid; height:30px'> " + dr["desc_despesa"].ToString().ToUpper() + " </th>";
                    table += "          <th style='border-bottom: 1px solid;'>" + dr["razaoSocial"].ToString() + "</th>";
                    table += "          <th style='border-bottom: 1px solid;'>" + dr["tipo_pgto"].ToString() + "</th>";
                    table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["num_parcela"]).ToString() + " </th>";
                    table += "          <th style='border-bottom: 1px solid'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                    table += "          <th style='border-bottom: 1px solid'> " + dr["vencimento"] + " </th>";
                    table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
                    table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnEditar'   type='button' class='btn btn-info' value='Editar' style='width:80px; height:23px; cursor: pointer; text-align:center; padding-top:initial ' /> </th>";
                    table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='excluirConta(" + dr["id"].ToString() + "); return false;' />  </th>";
                    table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnExcluir'  type='button' class='btn btn-success' value='Baixar' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='baixarConta(" + dr["id"].ToString() + "); return false;' />  </th>";
                    table += "          </tr> ";

                }

            }
            else
            {
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th colspan='10'style='border-bottom: 1px solid; height:30px'> Nenhuma informação encontrada. </th>";
                table += "          </tr> ";
            }

            dr.Close();
            cn.Close();

            table += "      </table> ";

            return table;

        }

        [WebMethod]
        public static String TabelaContasPagas(String status)
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
            cmd.CommandText = @"select cp.id, desp.desc_despesa, fornec.razaoSocial, obra.desc_obra, cp.tipo_pgto ,cp.num_parcela, cp.valor, convert(varchar(30),cp.dt_pagamento,103) as vencimento from tb_contasPagar cp
                               inner join tb_despesa desp on desp.id_despesa = cp.id_despesa
                               left join obra obra on obra.id_obra = cp.id_obra
                               LEFT join tb_cliente fornec on fornec.id = cp.fornec and fornec.tp_cli_fornc = 'fornecedor' WHERE cp.status = 'pago' order by 1 desc";


            String table = "";

            String cor_r = "#90EE90";

            table += "      <table id='tbDados' width=\"100%\" style='color:#333333;border-collapse:collapse;border-radius:4px'> ";

            table += "          <tr style='color:White;background-color:#5D7B9D;font-weight:'> ";
            table += "              <th  nowrap scope='col' align='left'   style=''>Descrição</th>";
            table += "              <th  nowrap scope='col' align='left'   style=''>Fornecedor</th>";
            table += "              <th  nowrap scope='col' align='right'  style='width:80px'>Form Pgto.</th>";
            table += "              <th  nowrap scope='col' style='width:80px; text-align:center'>Parcela</th>";
            table += "              <th  nowrap scope='col' style='width:80px; text-align:center'>Valor</th>";
            table += "              <th  nowrap scope='col' style='width:80px; text-align:center'>Data Pagto.</th>";
            table += "              <th  nowrap scope='col' style='text-align:center;width:80px'> Detalhar  </th>";
            table += "          </tr> ";

            cmd.CommandText = cmd.CommandText;

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                while (dr.Read())
                {

                    if (cor_r.Equals("#90EE90")) { cor_r = "#90EE90"; } else { cor_r = "#90EE90"; }


                    table += "          <tr                style='color:Black;background-color:" + cor_r + "'> ";
                    table += "          <th                style='border-bottom: 1px solid; height:30px'> " + dr["desc_despesa"].ToString().ToUpper() + " </th>";
                    table += "          <th                style='border-bottom: 1px solid;'>" + dr["razaoSocial"].ToString() + "</th>";
                    table += "          <th align='right'  style='border-bottom: 1px solid; width:80px'>" + dr["tipo_pgto"].ToString() + "</th>";
                    table += "          <th style='border-bottom: 1px solid;width:80px;text-align:rigth'> " + Convert.ToDouble(dr["num_parcela"]).ToString() + " </th>";
                    table += "          <th align='right'  style='border-bottom: 1px solid; width:80px'> " + Convert.ToDouble(dr["valor"]).ToString("N2") + " </th>";
                    table += "          <th align='center' style='border-bottom: 1px solid; width:80px'> " + dr["vencimento"] + " </th>";
                    table += "          <th  nowrap scope='col' align='center' style='width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnDetalhar' type='button' class='btn btn-info' value='Detalhar' style='width:80px; height:23px; cursor:pointer; text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' />  </th>";
                    table += "          </tr> ";

                }

            }
            else
            {
                table += "          <tr style='color:Black;background-color:" + cor_r + "'> ";
                table += "          <th colspan='10'style='border-bottom: 1px solid; height:30px'> Nenhuma informação encontrada. </th>";
                table += "          </tr> ";
            }

            dr.Close();
            cn.Close();
            table += "      </table> ";

            return table;

        }

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
        public static String TabelaDetalhesContas(String id)
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
            cmd.CommandText = @"select  id, desc_detalhe, qtde, valor, nf from tb_detalhes_contasPagar where id_conta =" + id;


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
                table += "          <th  nowrap scope='col' align='right' style='padding-right: 20px; width:80px; text-align:center; border-bottom: 1px solid'> <input id='btnExcluir'  type='button' class='btn btn-danger' value='Excluir' style='width:80px; height:23px; cursor: pointer;text-align:center; padding-top:initial ' onclick='detalhar(" + dr["id"].ToString() + "); return false;' /> </th>";
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
            cmd.CommandText = @"INSERT INTO tb_contasReceber
                                                                    (num_parcela
                                                                    ,tipo_pgto
                                                                    ,valor
                                                                    ,id_obra
                                                                    ,cliente
                                                                    ,dt_pagamento
                                                                    ,status
                                                                    ,id_conta_bancaria
                                                                    ,nm_cadastrou
                                                                    ,dt_cadastrou)
                                                              VALUES
                                                                    (@num_parcela
                                                                    ,@tipo_pgto
                                                                    ,@valor
                                                                    ,@id_obra
                                                                    ,@cliente
                                                                    ,@dt_pagamento
                                                                    ,@status
                                                                    ,@id_conta_bancaria
                                                                    ,@nm_cadastrou
                                                                    ,getdate())";


            cmd.Parameters.AddWithValue("@num_parcela", Contas.num_parcela_string);
            cmd.Parameters.AddWithValue("@tipo_pgto", Contas.tipo_pgto);
            cmd.Parameters.AddWithValue("@valor", Contas.valor_string);         
            cmd.Parameters.AddWithValue("@cliente", Contas.id_fornecedor);        
            cmd.Parameters.AddWithValue("@id_obra", Contas.id_obra);
            cmd.Parameters.AddWithValue("@status", Contas.nf);
            cmd.Parameters.AddWithValue("@id_conta_bancaria", Contas.conta_bancaria);
            cmd.Parameters.AddWithValue("@dt_pagamento", Convert.ToDateTime(Contas.data));
            cmd.Parameters.AddWithValue("@nm_cadastrou", "sistema"); 
           

            cmd.ExecuteNonQuery();
            cn.Close();

            return "OK";
        }

        [WebMethod]
        public static String ExcluirConta(String id)
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
            cmd.CommandText = @"delete tb_contasPagar where id = " + id;
            cmd.ExecuteNonQuery();

            //comando de instrução do banco de dados
            cmd.CommandText = @"delete tb_detalhes_contasPagar where id_conta = " + id;
            cmd.ExecuteNonQuery();

            cn.Close();
            return "OK";

        }

        [WebMethod]
        public static String BaixarConta(String id)
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
            cmd.CommandText = @"update tb_contasPagar set status = 'pago' where id = " + id;

            cmd.ExecuteNonQuery();
            cn.Close();

            return "OK";

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

        //[WebMethod]
        //public static Cliente ConsultarFornecedor(String id)
        //{
        //    Cliente getCliente = new Cliente();
        //    Dao consultarCliente = new Dao();
        //    getCliente = consultarCliente.ConsultarFornecedor(id);
        //    return getCliente;
        //}


    }
}