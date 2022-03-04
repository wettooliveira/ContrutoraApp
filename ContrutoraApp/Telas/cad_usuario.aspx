<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_usuario.aspx.cs" Inherits="cad_usuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <script type="text/javascript" src="Scripts/jquery-3.3.1.js"></script>
    <%--<script type="text/javascript" src="Scripts/bootstrap.js"></script>--%>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/SweetAlert2/sweetalert2.all.min.js"></script>
    <title>Usuarios</title>

    <script type="text/javascript">

        $(document).ready(function () {

            // Click event of the showPassword button
            $('#showPassword').on('click', function () {

                // Get the password field
                var passwordField = $('#txtSenha');

                // Get the current type of the password field will be password or text
                var passwordFieldType = passwordField.attr('type');

                // Check to see if the type is a password field
                if (passwordFieldType == 'Password') {
                    // Change the password field to text
                    passwordField.attr('type', 'text');

                    // Change the Text on the show password button to Hide
                    $(this).val('Ocultar');
                } else {
                    // If the password field type is not a password field then set it to password
                    passwordField.attr('type', 'Password');

                    // Change the value of the show password button to Show
                    $(this).val('Mostrar');
                }
            });
        });

        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },
            buttonsStyling: false
        });


        function openCidade() {
            abrir_janela("loc_regiao.aspx", "lr", 600, 350, 1);
        }

        function alertCss(mensagem) {
            texto == '';
            icon == '';
            if (mensagem == ('Gravado')) {
                var texto = ('Gravado com sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('Alterado')) {
                var texto = ('Alterado com Sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('tipo')) {
                var texto = ('Campo Obrigatório');
                var icon = ('error');
            }

            swalWithBootstrapButtons.fire({
                title: '',
                text: texto,
                icon: icon,
                confirmButtonText: 'OK',
                allowOutsideClick: false
            });
        }

        function nome(id_usuario) {
            document.getElementById("hdnId_usuario").value = id_usuario;
            document.getElementById("hdnAcao").value = "usuario"
            form1.submit();
        }

        function CarregarInf() {
            document.getElementById("txtNomeModal").value = document.getElementById("txtNome").value;
            document.getElementById("txtUsuarioModal").value = document.getElementById("txtUsuarioSenha").value;
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
    </style>

    <style type="text/css">
        .Grid {
            background-color: #fff;
            margin: 5px 0 10px 0;
            border: solid 1px #525252;
            border-collapse: collapse;
            font-family: Calibri;
            color: #474747;
        }
    </style>

</head>

<body >

    <form id="form1" runat="server">
        <asp:HiddenField ID="nm_session" runat="server" />
        <asp:HiddenField ID="hdnId_usuario" runat="server" />
        <asp:HiddenField ID="hdnAcao" runat="server" />
       

        <table width="100%">
            <tr>
                <td>
                    <br />
                    <br />
                    <table style="width: 99%">
                        <tr>
                            <td style="height: 40px">
                                <asp:Label ID="lblnome" Font-Size="Small" runat="server" Text="Nome Completo:"></asp:Label>
                            </td>
                            <td style="text-align: left; height: 40px">
                                <asp:TextBox ID="txtNome" Width="400px" Enabled="false" CssClass="form-control-css" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px">
                                <asp:Label ID="lblds_usuario" Font-Size="Small" runat="server" Text="Usuario:"></asp:Label></td>
                            <td style="height: 40px">
                                <asp:TextBox ID="txtUsuarioSenha" Enabled="false" CssClass="form-control-css" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px">
                                <asp:Label ID="lblSenha" Font-Size="Small" runat="server" Text="Senha:"></asp:Label></td>
                            <td style="height: 40px">
                                <asp:TextBox ID="txtSenha" Enabled="false" CssClass="form-control-css" name="password" type="Password" runat="server" AutoComplete="new-password"></asp:TextBox>
                                <input type="button" id="showPassword" value="Mostrar" class="btn btn-default" />
                                <input type="button" id="btnAlterarSenha" value="Alterar" runat="server" class="btn btn-default hidden" onclick="CarregarInf()" data-toggle="modal" data-target="#myModal" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnGravar" Text="Gravar" runat="server" CssClass="btn btn-success" OnClick="btnGravar_Click" />
                                <asp:Button ID="btnFiltrar" Text="Buscar" CssClass="btn btn-primary" runat="server" OnClick="btnFiltrar_Click" />
                            </td>
                        </tr>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <br />
                </td>
            </tr>

            <tr>
                <td style="width: 260px"></td>
                <td align="">
                    <asp:GridView ID="GridUsuario" CssClass="Grid" runat="server" AutoGenerateColumns="false" Width="600px"
                        AllowPaging="true" PageSize="8" AlternatingRowStyle-CssClass="alt" PagerStyle-CssClass="pgr" HeaderStyle-HorizontalAlign="Center">
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
        </div>
    </form>

</body>

</html>

