using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MapItChase.Startup))]
namespace MapItChase
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
