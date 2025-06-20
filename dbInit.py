from app import CreateApp, Database
Application = CreateApp().createApp()
Application.app_context().push()
Database.create_all()