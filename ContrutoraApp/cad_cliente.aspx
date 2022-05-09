﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_cliente.aspx.cs" Inherits="cad_cliente" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>
    <%-- <script type="text/javascript" src="../Scripts/jquery-3.3.1.js"></script>--%>
    <%--<link rel="stylesheet" type="text/css" href="../Css/Menu.css" media="screen" />--%>
    <script type="text/javascript" src="../Scripts/SweetAlert2/sweetalert2.all.min.js"></script>

    <title></title>

    <script type="text/javascript" language="javascript">
        const { checked } = require("modernizr");

        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },
            buttonsStyling: false
        });

        function Inserir() {

            var tipo;

            if ($("#riCliente").is(':checked')) {
                tipo = "cliente";
            } else if ($('#riFornecedor').is(':checked')) {
                tipo = "fornecedor";
            }
         
            var RazaoSocial = $('#txtRazaoSocial').val();
            var CNPJ = $('#txtCnpj').val();
            var IE = $('#txtInscricao').val();
            var Tel = $('#txtTel').val();
            var obs = "texte";
            var CEP = $('#txtCEP').val();
            var logradouro = $('#txtEndereco').val();
            var numero = $('#txtNumero').val();
            var complemento = $('#txtComplemento').val();
            var bairro = $('#txtBairro').val();
            var cidade = $('#txtCidade').val();
            var UF = $('#txtUF').val();
            var usuario = $('#hdnUsuario').val();

            var Endereco = {
                cep: CEP,
                logradouro: logradouro,
                numero: numero,
                complemento: complemento,
                bairro: bairro,
                cidade: cidade,
                uf: UF
            };

            var Cliente = {
                RazaoSocial: RazaoSocial,
                CNPJ: CNPJ,
                IE: IE,
                tel: Tel,
                obs: obs,
                nm_cadastrou: usuario,
                endereco: Endereco,
                tp_cli_fornc: tipo
            };

            var obj = { 'cliente': Cliente };

            var URL
            if ($('#btnGravar').val() == 'Gravar') {
                URL = "cad_cliente.aspx/Gravar";
            } else {
                URL = "cad_cliente.aspx/Alterar";
            }

            $.ajax({
                type: "POST",
                url: URL,
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {


                    if (data.d.split(',')[0] == 'OK') {
                        $('#lblAviso').html('');
                        if (data.d.split(',')[1] == 'gravar') {
                           
                            alertCss('Gravar');
                        } else {
                           
                            alertCss('Alterar');
                        }
                      

                    } else if (data.d.split(',')[0] == 'ERRO') {
                        $('#lblAviso').html('');
                        $('#lblAviso').html('Tente novamente, algo deu errado!');
                        $('#lblAviso').css('color', 'red');
                    }

                },
                error: function (request, status, error) {
                    alert(request.responseText);
                    console.log(request.responseText);
                    //swalWithBootstrapButtons.fire({
                    //    title: '',
                    //    text: 'Erro ao abrir tabela! Tente novamente!',
                    //    icon: 'error',
                    //    confirmButtonText: 'OK',
                    //    allowOutsideClick: false
                    //}).then((result) => {
                    /*  });*/
                }
            });

        }

        function alertCss(mensagem) {

            texto == '';
            icon == '';
            if (mensagem == ('Gravar')) {
                var texto = ('Gravado com sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('Alterar')) {
                var texto = ('Alterado com Sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('Cancelar')) {
                var texto = ('Cancelado com Sucesso');
                var icon = ('success');
                /*var icon = ('error');*/
            }

            swalWithBootstrapButtons.fire({
                title: '',
                text: texto,
                icon: icon,
                confirmButtonText: 'OK',
                allowOutsideClick: false
            });
        }

        function BuscarCep(cep) {

            $.ajax({
                type: "POST",
                url: "cad_cliente.aspx/BuscarCEP",
                data: "{'cep':'" + cep + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    $('#txtEndereco').val('');
                    $('#txtBairro').val('');
                    $('#txtCidade').val('');
                    $('#txtUF').val('');

                    if (source.logradouro == 'ERRO') {

                    } else {

                        $('#txtEndereco').val(source.logradouro);
                        $('#txtBairro').val(source.bairro);
                        $('#txtCidade').val(source.cidade);
                        $('#txtUF').val(source.uf);
                    }

      


                },
                error: function (request, status, error) {
                    alert(request.responseText);
                    console.log(request.responseText);
                    //swalWithBootstrapButtons.fire({
                    //    title: '',
                    //    text: 'Erro ao abrir tabela! Tente novamente!',
                    //    icon: 'error',
                    //    confirmButtonText: 'OK',
                    //    allowOutsideClick: false
                    //}).then((result) => {
                    /*  });*/
                }
            });

        }

        function BuscarCliente() {

            window.open("consultar_cliente.aspx", "popup", "toolbar=no,scrollbars=no,resizable=no,lr,left=250,width=400,height=400,top=100");
        }

        function selCliente(id, nome, cnpj) {

            $.ajax({
                type: "POST",
                url: "cad_cliente.aspx/CarregarCliente",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;
                   
                    if (source.tp_cli_fornc == 'cliente') {
                        $("#riCliente").prop("checked", true);

                    } else {

                        $("#riFornecedor").prop("checked", true);
                    }

                    $('#txtRazaoSocial').val(source.RazaoSocial);
                    $('#txtCnpj').val(source.CNPJ);
                    $('#txtInscricao').val(source.IE);
                    $('#txtTel').val(source.tel);
                    $('#txtCEP').val(source.endereco.cep);
                    $('#txtEndereco').val(source.endereco.logradouro);
                    $('#txtNumero').val(source.endereco.numero);
                    $('#txtComplemento').val(source.endereco.complemento);
                    $('#txtBairro').val(source.endereco.bairro);
                    $('#txtCidade').val(source.endereco.cidade);
                    $('#txtUF').val(source.endereco.uf);

                    $('#btnGravar').val('Alterar');

                },
                error: function (request, status, error) {
                    alert(request.responseText);
                    console.log(request.responseText);
                    //swalWithBootstrapButtons.fire({
                    //    title: '',
                    //    text: 'Erro ao abrir tabela! Tente novamente!',
                    //    icon: 'error',
                    //    confirmButtonText: 'OK',
                    //    allowOutsideClick: false
                    //}).then((result) => {
                    /*  });*/
                }
            });
        }

    </script>

    <style>
        /* Estilo do alert */
        .swal2-popup {
            font-size: medium !important;
        }
        .btn {
            margin: 0 0.5rem;
            font-size: medium !important;
        }
        /*Termina aqui o style do Alert*/

        .radioinput {
            width: 18px;
            height: 18px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnUsuario" runat="server" />
        <div>
            <center>
                <table>
                    <tr>
                        <td>
                            <center>
                                <h3>Cadastrar Cliente</h3>
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="radio" runat="server" class="radioinput" id="riCliente" name="fav_language" value="cliente" />
                            <label>Cliente</label>
                            &nbsp;&nbsp;
                                <input type="radio" runat="server" class="radioinput" id="riFornecedor" name="fav_language" value="fornecedor" />
                            <label>Fornecedor</label>

                        </td>
                    </tr>
                    <tr class="trBody">
                        <td style="display: inline-flex">
                            <asp:TextBox ID="txtRazaoSocial" runat="server" placeholder="Nome\Razão Social" CssClass="form-control" Width="500px"></asp:TextBox>
                            &nbsp;&nbsp;
                            <input type="image" src="../Css/Imagens/lupa.png" style="width: 30px; height: 30px" title="Consultar Cliente" onclick="BuscarCliente();return false;" />
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtCnpj" runat="server" placeholder="CPF\CNPJ" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtInscricao" runat="server" placeholder="RG\IE" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtTel" runat="server" placeholder="Telefone" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtCEP" runat="server" placeholder="CEP" CssClass="form-control" Width="200px" onkeypress="return txtBoxFormat(this, '99999-999', event);" onblur="BuscarCep(this.value);" MaxLength="9"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 500px">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtEndereco" runat="server" placeholder="Endereco" CssClass="form-control" Width="400px"></asp:TextBox>
                                    </td>
                                    <td style="width: 20px"></td>
                                    <td>
                                        <asp:TextBox ID="txtNumero" runat="server" placeholder="numero" CssClass="form-control" Width="80px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtComplemento" runat="server" placeholder="Complemento" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtBairro" runat="server" placeholder="Bairro" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 500px">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtCidade" runat="server" placeholder="Cidade" CssClass="form-control" Width="200px"></asp:TextBox>
                                    </td>
                                    <td style="width: 220px"></td>
                                    <td>
                                        <asp:TextBox ID="txtUF" runat="server" placeholder="UF" CssClass="form-control" Width="80px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>

                    <%--<tr>
                        <td>
                            <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Selecione" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Dinheiro" Value="dinheiro"></asp:ListItem>
                                <asp:ListItem Text="Débito" Value="debito"></asp:ListItem>
                                <asp:ListItem Text="Crédito" Value="credito"></asp:ListItem>
                                <asp:ListItem Text="Cheque" Value="cheque"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                        <td>
                            <asp:TextBox ID="txtParcela" runat="server" placeholder="Parcela" CssClass="form-control"></asp:TextBox>
                        </td>

                        <td>
                            <asp:TextBox ID="txtValor" runat="server" placeholder="Valor" CssClass="form-control"></asp:TextBox>
                        </td>

                       
                    </tr>--%>
                    <tr>
                        <td style="text-align: center">
                            <br />
                            <asp:Button runat="server" ID="btnGravar" CssClass="btn btn-success" Text="Gravar" OnClientClick="Inserir();return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            <asp:Label runat="server" ID="lblAviso"></asp:Label>
                        </td>
                    </tr>
                </table>
            </center>
        </div>
        <div style="width: 100%">
            <br />
            <br />
            <center>
                <table style="width: 70%">
                    <tr>
                        <td>
                            <div id="div"></div>
                        </td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>