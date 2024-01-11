use axum::{http::StatusCode, routing::any, Router};

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", any(two_oh_four))
        .route("/*0", any(two_oh_four));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
async fn two_oh_four() -> StatusCode {
    StatusCode::NO_CONTENT
}
