var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello updated again World!");
app.MapGet("/whoami", () => "It'se me!");

app.Run();
