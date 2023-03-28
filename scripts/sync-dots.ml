let home = Sys.getenv "HOME"

let resolve_dots (dot : string) =
  let is_symlink (stat : Unix.stats) = stat.Unix.st_kind = Unix.S_LNK in
  let fullpath = Filename.concat home dot in
  let stat = Unix.lstat fullpath in
  if is_symlink stat then Unix.readlink fullpath else fullpath

let servers =
  if Array.length Sys.argv > 1 then Sys.argv
  else
    [|
      (* 5950x *)
      "shinx";
      "luxio";
      "manectric";
      "minun";
      (* Unmatched *)
      "larvesta";
      "reshiram";
      "incineroar";
      "talonflame";
      "volcanion";
      "torracat";
      "oricorio";
    |]

let dotfiles =
  [ ".vimrc"; ".bashrc"; ".tmux.conf" ]
  |> List.map (fun dot -> resolve_dots dot)

let rsync ~(remote : string) ~(files : string list) =
  Format.printf "$ rsync -azvhP %s %s\n" (String.concat " " files) remote

let () = servers |> Array.iter (fun srv -> rsync ~remote:srv ~files:dotfiles)
