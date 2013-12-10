using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.Utilities;
using Microsoft.SharePoint.WebControls;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web.UI.WebControls;

namespace Nauplius.SharePoint.CrawlTarget.Layouts.Nauplius.SharePoint.CrawlTarget
{
    public partial class Target : LayoutsPageBase
    {
        private SPWebApplication _webApplication;

        protected void Page_Init(object sender, EventArgs e)
        {
            var farm = SPFarm.Local;
            var webAppId = new Guid(Request["Id"]);
            try
            {
                _webApplication = (SPWebApplication)farm.GetObject(webAppId);
            }
            catch (SPException)
            {
                SPUtility.TransferToErrorPage("An error occurred attempting to resolve the Web Application ID, please contact your Administrator.");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            btnAdd.Attributes.Add("onclick", "NewCrawlTarget('" + _webApplication.GetResponseUri(SPUrlZone.Default).AbsoluteUri + "'); return false;");
            
            if (IsPostBack) return;
            if (_webApplication == null) return;

            var servers = SPFarm.Local.Servers;

            if (servers.Count == 1 && Debugger.IsAttached != true)
            {
                SPUtility.TransferToErrorPage("There is only one server in the farm. Please add additional servers to use this feature.");
            }

            PopulateGridView();
        }

        protected void PopulateGridView()
        {
            var sds = Mapping.GetMapping(_webApplication);

            if (sds == null)
            {
                GvItems.Visible = false;
                lblNoTargets.Visible = true;
                return;
            }

            GvItems.DataSource = sds;
            GvItems.DataBind();
        }

        protected void chkBoxSL_CheckedChanged(object sender, EventArgs e)
        {
            foreach (CheckBox chk in from GridViewRow rowItem in GvItems.Rows select (CheckBox)(rowItem.Cells[0].FindControl("chkId")))
            {
                chk.Checked = ((CheckBox)sender).Checked;
            }
        }

        protected void btnDelete_OnDelete(object sender, EventArgs e)
        {
            for (int i = 0; i < GvItems.Rows.Count; i++)
            {
                var chkDelete = (CheckBox) GvItems.Rows[i].Cells[0].FindControl("chkId");

                if (chkDelete.Checked)
                {
                    var lblZone = (Label)GvItems.Rows[i].Cells[1].FindControl("lblZone");

                    SPUrlZone zone;
                    SPUrlZone.TryParse(lblZone.Text, out zone);
                    Mapping.RemoveMapping(_webApplication, zone);
                }
            }

            PopulateGridView();
        }

        protected void GvItems_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.DataItem != null)
            {
                var label = (Label)e.Row.FindControl("lblServer");
                
                string[] uris = ((KeyValuePair<SPUrlZone, List<Uri>>)e.Row.DataItem).Value.Select(x => x.ToString()).ToArray();
                label.Text = string.Join(", ", uris);
            }
        }
    }
}
