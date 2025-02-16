var builder = WebApplication.CreateBuilder(args);
builder.Services.AddHealthChecks();
var app = builder.Build();

app.MapHealthChecks("/healthz");

app.MapGet("/", () => "Hello updated again World!");
app.MapGet("/whoami", () => "It'se me!");
app.MapGet("/preview-feature", () => "This is super new!");
app.MapGet("/greet/{userId}", (int userId) => $"Hello {userId}!");

app.Run();
