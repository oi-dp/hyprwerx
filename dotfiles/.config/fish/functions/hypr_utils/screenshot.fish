function screenshot
  grim -g "$(slurp -d)" $HOME/Pictures/Screenshots/(date +%Y-%m-%d_%H-%M-%S).png
end
