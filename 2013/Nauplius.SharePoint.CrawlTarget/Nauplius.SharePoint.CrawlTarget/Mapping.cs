using Microsoft.SharePoint.Administration;
using System;
using System.Collections.Generic;
using System.Linq;

namespace Nauplius.SharePoint.CrawlTarget
{
    public class Mapping
    {
        public static void AddMapping(SPWebApplication webApp, SPUrlZone zone, SPServer server)
        {
            if (webApp == null || server == null) return;
            var uri = new Uri("http://" + server.Name);
            var list = new List<System.Uri>(1) { uri };
            try
            {
                webApp.SiteDataServers.Add(zone, list);
                webApp.Update();
            }
            catch (ArgumentException) //duplicate key
            {
            }
        }

        public static SDS GetMapping(SPWebApplication webApp)
        {
            var sds = new SDS();
            if (webApp.SiteDataServers.Count < 1) return null;

            foreach (var t in webApp.SiteDataServers)
            {
                sds.Add(t.Key, new Uri(t.Value[0].ToString()));
            }
            return sds;
        }
        public static void RemoveMapping(SPWebApplication webApp, SPUrlZone zone)
        {
            if (webApp == null) return;
            webApp.SiteDataServers.Remove(zone);
            webApp.Update();
        }

        public static void HttpThrottle(SPServer server, bool remove)
        {
            foreach (var t in server.ServiceInstances.Where(service => service.TypeName == @"Microsoft SharePoint Foundation Web Application").Cast<SPWebServiceInstance>())
            {
                t.DisableLocalHttpThrottling = remove;
                t.Update();
            }
        }

        public static bool EnumHttpThrottle(SPServer server)
        {
            return server.ServiceInstances.Where(service => service.TypeName == @"Microsoft SharePoint Foundation Web Application").Cast<SPWebServiceInstance>().Select(t => t.DisableLocalHttpThrottling).FirstOrDefault();
        }
    }
}
