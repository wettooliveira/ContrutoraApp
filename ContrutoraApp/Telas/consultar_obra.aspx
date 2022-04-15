<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="consultar_obra.aspx.cs" Inherits="consultar_obra" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <%--    <script type="text/javascript" src="../Scripts/bootstrap.js"></script>--%>
    <%--   <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>--%>
    <script type="text/javascript" src="../Scripts/jquery-3.3.1.js"></script>
    <%--    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>--%>
    <script type="text/javascript" src="../Scripts/SweetAlert2/sweetalert2.all.min.js"></script>

    <title>Usuarios</title>

    <script language="javascript" type="text/javascript">
        {
            window.resizeTo(800, 600);
        }

        function seleciona(id, nome, cnpj) {           
            window.opener.selObra(id);
            window.close();
        }

        function cadCliente() {
            if (location.search.match(/Remetente/)) {
                window.location = "cad_cliente.aspx?tipo=Remetente";
            }
            else if (location.search.match(/Destinatario/)) {
                window.location = "cad_cliente.aspx?tipo=Destinatario";
            }
            else if (location.search.match(/Consignatario/)) {
                window.location = "cad_cliente.aspx?tipo=Consignatario";
            }
            else if (location.search.match(/Expedidor/)) {
                window.location = "cad_cliente.aspx?tipo=Expedidor";
            }
            else if (location.search.match(/Recebedor/)) {
                window.location = "cad_cliente.aspx?tipo=Recebedor";
            }
            else if (location.search.match(/Nota/)) {
                window.location = "cad_cliente.aspx?tipo=Nota";
            }
        }

        function alertar(msg) {
            alert(msg);
        }

    </script>

    <style type="text/css">
        /* Estilo do alert */
        .swal2-popup {
            font-size: medium !important;
        }

        .btn {
            margin: 0 0.5rem;
            font-size: medium !important;
        }
        /*Termina aqui o style do Alert*/

        /* #GridUsuario {
            background-color: #fff;
            margin: 5px 0 10px 0;
            border: solid 1px #525252;
            border-collapse: collapse;
            font-family: Calibri;
            color: #474747;
        }*/


        .Grid td {
            padding: 2px;
            border: solid 1px #c1c1c1;
        }

        .Grid th {
            padding: 4px 2px;
            color: #fff;
            background: #4682B4;
            border-left: solid 1px #525252;
            font-size: 0.9em;
        }

        .Grid .alt {
            background: #F8F8FF;
        }

        .Grid .pgr {
            background: #4682B4;
        }

            .Grid .pgr table {
                margin: 3px 0;
            }

            .Grid .pgr td {
                border-width: 0;
                padding: 0 6px;
                border-left: solid 1px #666;
                font-weight: bold;
                color: #fff;
                line-height: 12px;
            }

        .Grid tr:hover {
            background-color: #4682B4;
            color: white;
        }

        .Grid td:hover {
            cursor: pointer;
        }

        .Grid pgr:hover {
            cursor: pointer;
        }

        .Grid .pgr a {
            color: Gray;
            text-decoration: none;
        }

            .Grid .pgr a:hover {
                color: #fff;
                text-decoration: none;
            }
    </style>

</head>

<body>

    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hdnAdm" />
        <asp:HiddenField runat="server" ID="hdnCad" />
        <table width="100%">
            <tr>
                <td colspan="4">
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <label for="txtRazaoSocial">
                        Nome da Obra:
                    </label>
                </td>
                <td>
                    <asp:TextBox ID="txtNomeObra" CssClass="form-control" runat="server" Width="280px"></asp:TextBox>

                </td>
                <td class="hidden">
                    <label for="txtRazaoSocial">
                        Tipo Cliente:
                    </label>
                </td>
                <td class="hidden">
                    <asp:DropDownList runat="server" ID="ddlTipoCliente" CssClass="form-control" Width="200px"></asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar"
                        CssClass="btn btn-abc-verde" OnClick="btnFiltrar_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center"></td>
            </tr>
            <tr>
                <td colspan="4">
                    <hr />
                </td>
            </tr>
        </table>
        <br />

        <center>
            <asp:Label runat="server" ID="lblCadCliente" Visible="false">Nenhum cliente encontrado! Busque novamente ou <a onclick="cadCliente();" style="cursor: pointer;"> clique aqui para cadastrar</a></asp:Label>
            <asp:Label runat="server" ID="lblCliente" Visible="false">Nenhum cliente encontrado!</asp:Label>
        </center>

        <asp:GridView ID="gdvObra" runat="server" CssClass="Grid" AutoGenerateColumns="False" Width="100%" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt" PagerStyle-CssClass="pgr" HeaderStyle-HorizontalAlign="Center" SelectedRowStyle-CssClass="row" OnPageIndexChanging="gdvCliente_PageIndexChanging" >
            
         <%--   <HeaderStyle CssClass="titulo" />--%>
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        Numero Obra
                    </HeaderTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <div>
                            <b><span style="cursor: pointer;" onclick="seleciona('<%# DataBinder.Eval(Container.DataItem,"id") %>')">
                                <%# DataBinder.Eval(Container.DataItem, "id")%> </span></b>                              
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            
                <asp:BoundField HeaderText="Nome Obra" DataField="nome" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Endereco" DataField="endereco.logradouro" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Cliente" DataField="cliente.RazaoSocial" ItemStyle-HorizontalAlign="Center" /> 
                <%--<asp:TemplateField>
                    <HeaderTemplate>
                        Código Interno
                    </HeaderTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <%# DataBinder.Eval(Container.DataItem, "cod_interno")%>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <%-- <asp:TemplateField>
                    <HeaderTemplate>
                        Cidade
                    </HeaderTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <div>
                            <%# DataBinder.Eval(Container.DataItem,"endereco.cidade.cidade") %>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <%--<asp:BoundField HeaderText="Cidade" DataField='' ItemStyle-HorizontalAlign="Center" />--%>
                <%-- <asp:BoundField HeaderText="Status" DataField="fl_ativo" ItemStyle-HorizontalAlign="Center" />--%>
            </Columns>
        </asp:GridView>




        <%--<div>
            <center>
                <table>
                    <tr>
                        <td align="">
                            <asp:GridView ID="GridUsuario" CssClass="Grid" runat="server" AutoGenerateColumns="false" Width="600px"
                                AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt" PagerStyle-CssClass="pgr" HeaderStyle-HorizontalAlign="Center" OnPageIndexChanging="GridUsuario_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Nome
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <span style="cursor: pointer;" onclick="nome( '<%# DataBinder.Eval(Container.DataItem, "id_usuario")%> ')" />
                                            <%# DataBinder.Eval(Container.DataItem, "ds_nome")%>
                                       </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="" DataField="usuario" HeaderText="usuario" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>

            </center>
        </div>




        <div class="container">

            <!-- Modal -->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Alterar Senha</h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td style="height: 40px; width: 150px">Nome Completo:

                                    </td>
                                    <td style="text-align: left; height: 40px">

                                        <asp:TextBox ID="txtNomeModal" Width="350px" CssClass="form-control-css" runat="server"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Usuario:
                                    </td>
                                    <td style="height: 40px">
                                        <asp:TextBox ID="txtUsuarioModal" CssClass="form-control-css" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Senha Atual:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtSenhaAtualModal" Width="140px" CssClass="form-control-css"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Nova Senha:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtNovaSenhaModal" Width="140px" CssClass="form-control-css"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Confirmar Senha:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtconfSenhaModal" Width="140px" CssClass="form-control-css" ControlToValidate="txtconfSenhaModal"></asp:TextBox>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Senhas são diferentes" ControlToCompare="txtNovaSenhaModal" ControlToValidate="txtconfSenhaModal"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
    </form>

</body>

</html>

