{config, ...}: {
  programs.zen-browser.profiles.default = {
    containersForce = true;
    containers = {
      Personal = {
        color = "purple";
        icon = "fingerprint";
        id = 1;
      };
      Work = {
        color = "blue";
        icon = "briefcase";
        id = 2;
      };
      Learning = {
        color = "green";
        icon = "chill";
        id = 3;
      };
      "Halal Learning" = {
        color = "green";
        icon = "gift";
        id = 4;
      };
      Streaming = {
        color = "red";
        icon = "chill";
        id = 5;
      };
      Mails = {
        color = "yellow";
        icon = "fingerprint";
        id = 6;
      };
      "Artificial Intelligence" = {
        color = "orange";
        icon = "circle";
        id = 7;
      };
    };
    spacesForce = true;
    spaces = let
      containers = config.programs.zen-browser.profiles."default".containers;
    in {
      "Personal" = {
        id = "c6de089c-410d-4206-961d-ab11f988d40a";
        container = containers.Personal.id;
        position = 1000;
      };
      "Work" = {
        id = "cdd10fab-4fc5-494b-9041-325e5759195b";
        icon = "💼";
        container = containers.Work.id;
        position = 2000;
      };
      "Learning" = {
        id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
        icon = "📚";
        container = containers.Learning.id;
        position = 3000;
      };
      "Halal Learning" = {
        id = "89bccdad-9abf-5fe1-9ff1-3b1d7d5ddd35";
        icon = "☪️";
        container = containers."Halal Learning".id;
        position = 4000;
      };
      "Streaming" = {
        id = "92cddeae-0bcf-6ff2-aff2-4c2e8e6eee46";
        icon = "🎬";
        container = containers.Streaming.id;
        position = 5000;
      };
      "Mails" = {
        id = "a2deefbf-1cd0-5ff2-cff2-4c2e8e6eee55";
        icon = "📧";
        container = containers.Mails.id;
        position = 6000;
      };
      "Artificial Intelligence" = {
        id = "a3deefbf-1cd0-7gg3-bgg3-5d3f9f7fff57";
        icon = "🤖";
        container = containers."Artificial Intelligence".id;
        position = 7000;
      };
    };
  };
}
