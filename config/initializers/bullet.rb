ResistanceFishtagRu::Application.config.after_initialize do
  Bullet.enable = true
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.add_footer = true
end
