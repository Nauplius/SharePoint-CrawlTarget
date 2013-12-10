<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Microsoft.SharePoint.Administration" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Target.aspx.cs" Inherits="Nauplius.SharePoint.CrawlTarget.Layouts.Nauplius.SharePoint.CrawlTarget.Target" DynamicMasterPageFile="~masterurl/default.master" %>

<%@ Register TagPrefix="wssuc" TagName="ToolBar" src="~/_controltemplates/15/ToolBar.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <style type="text/css">
        ms-cbp { border-top: 0px;padding-right: 15px;padding-top: 0px;padding-bottom: 0px; width:50px }
    </style>
    <script type="text/javascript">
        function NewCrawlTarget(webAppUri) {
            var targetUrl = "/_admin/Nauplius.SharePoint.CrawlTarget/NewCrawlTarget.aspx?WA=" + webAppUri + "&IsDlg=1";

            var options = {
                url: targetUrl,
                args: null,
                title: 'Add Crawl Target for ' + webAppUri,
                dialogReturnCallback: childCallback,
            };
            SP.SOD.execute('sp.ui.dialog.js', 'SP.UI.ModalDialog.showModalDialog', options);

            function childCallback(dialogResult, returnValue) {
                SP.UI.ModalDialog.RefreshPage(0);
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <wssuc:ToolBar id="onetidPolicyTB" runat="server" CssClass="ms-toolbar">
        <Template_Buttons>
            <asp:Button runat="server" ID="btnAdd" Text="Add Crawl Target" />
            <asp:Button runat="server" ID="btnDelete" OnClick="btnDelete_OnDelete" Text="Delete Crawl Target" />
        </Template_Buttons>
    </wssuc:ToolBar>
    
	<SharePoint:SPGridView
		id="GvItems"
		runat="server"
		AutoGenerateColumns="false"
		width="100%"
		AllowSorting="True" OnRowDataBound="GvItems_OnRowDataBound" >
	<AlternatingRowStyle CssClass="ms-alternatingstrong" />
	<Columns>
		<asp:TemplateField ItemStyle-CssClass="ms-cbp" HeaderStyle-CssClass="ms-cbp" ItemStyle-VerticalAlign="Top">
            <HeaderTemplate>
                <asp:CheckBox ID="chkBoxSL" 
                    runat="server"
                    AutoPostBack="true"
                    OnCheckedChanged="chkBoxSL_CheckedChanged"
                    style="margin-top:-1px; margin-bottom:-1px;" />
            </HeaderTemplate>
            <ItemTemplate>
                <asp:CheckBox ID="chkId" 
                    runat="server" 
                    class="padding-right: 15px;padding-top: 0px;padding-bottom: 0px" />
            </ItemTemplate>
		</asp:TemplateField>
  		<asp:TemplateField HeaderText="Web Application Zone" HeaderStyle-Width="50%" HeaderStyle-CssClass="ms-vh2-nofilter-perm" SortExpression="Key">
		    <ItemTemplate>
		        <asp:Label ID="lblZone" runat="server" Text='<%# Eval("Key") %>' />
		    </ItemTemplate>
		</asp:TemplateField>
		<asp:TemplateField HeaderText="Crawl Target" HeaderStyle-Width="50%" HeaderStyle-CssClass="ms-vh2-nofilter-perm" SortExpression="Value">
		    <ItemTemplate>
			    <asp:Label ID="lblServer" runat="server" Text='<%#Eval("Value") %>' />	        
		    </ItemTemplate>
		</asp:TemplateField>

	</Columns>
  </SharePoint:SPGridView>
    <asp:Label runat="server" ID="lblNoTargets" Visible="false" Text="There are no crawl target mappings on this Web Application. Please add a new crawl target mapping." /> 
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Nauplius - Web Application Crawl Target Settings
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
