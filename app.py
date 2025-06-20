import app

App = app.CreateApp().createApp()

if __name__ == "__main__":
    App.run(debug=True, host="0.0.0.0", port=3110)