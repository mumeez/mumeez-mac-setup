;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; ── Identity ──────────────────────────────────────────────────────────────
(setq user-full-name "Mumeez"
      user-mail-address "mumeez85@proton.me")

;; ── Fonts ─────────────────────────────────────────────────────────────────
;; CaskaydiaCove Nerd Font - Cascadia Code + Nerd Font icons
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16)
      doom-big-font (font-spec :family "CaskaydiaCove Nerd Font" :size 18)
      doom-symbol-font (font-spec :family "Symbols Nerd Font Mono" :size 16)
      doom-serif-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16))

;; ── Theme ──────────────────────────────────────────────────────────────────
(setq doom-theme 'doom-one)

;; ── UI / Behavior ─────────────────────────────────────────────────────────
(setq display-line-numbers-type t       ;; absolute line numbers
      confirm-kill-emacs nil            ;; just quit, no questions
      mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil)

;; ── Org Mode ──────────────────────────────────────────────────────────────
(setq org-directory "~/org/"
      org-agenda-files '("~/org/" "~/org/roam/tasks/")
      org-default-notes-file (expand-file-name "notes.org" org-directory)
      org-id-link-to-org-use-id t)

;; Org-roam: knowledge management (notes live in ~/org/roam/)
(setq org-roam-directory (file-truename "~/org/roam/")
      org-roam-completion-everywhere t
      org-roam-graph-link-hidden-types nil
      org-roam-graph-viewer "open")

;; Org-download: drag-and-drop images
(after! org
  (setq org-download-method 'directory
        org-download-image-dir (expand-file-name "images" org-directory))
  (add-to-list 'org-file-apps '("\\.pdf\\'" . default)))

;; Org mode visual settings
(setq org-hide-emphasis-markers t
      org-hide-leading-stars t
      org-odd-levels-only t
      org-pretty-entities t
      org-return-follows-link t
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-startup-indented t
      org-startup-folded 'content
      org-image-actual-width '(600))

;; Org-mode toggles: press `TAB` on headers to fold/unfold
;; `S-TAB` for global folding

;; Org-roam-ui: interactive force-directed graph (SPC n r u)
(after! org-roam-ui
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-remote t)
  (map! :leader
        :desc "Org-roam UI graph" "n r u" #'org-roam-ui-open
        :desc "Org-roam static graph" "n r g" #'org-roam-graph))

;; Org capture templates (SPC x to capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
         "* TODO %?\n%i\n%a")
        ("n" "Note" entry (file+olp "~/org/notes.org" "Notes")
         "* %?\n%i\n%U")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\n%i\n%U")))

;; ── macOS specific ────────────────────────────────────────────────────────
(when (featurep :system 'macos)
  ;; Use `open' command for external links (browser, etc.)
  (setq browse-url-browser-function 'browse-url-default-macosx-browser
        ns-pop-up-frames nil
        mac-option-modifier 'none
        mac-command-modifier 'meta))

;; ── Editor tweaks ─────────────────────────────────────────────────────────
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Spell check (enable with M-x spell-mode or SPC t s)
;; (after! flyspell
;;   (setq ispell-program-name "aspell"))

;; ── Modeline ──────────────────────────────────────────────────────────────
(setq doom-modeline-major-mode-icon t
      doom-modeline-buffer-file-name-style 'truncate-with-project
      doom-modeline-minor-modes nil
      doom-modeline-enable-word-count nil)

;; ── Dashboard ─────────────────────────────────────────────────────────────
(setq +doom-dashboard-ascii-banner-file nil  ; no ascii banner
      dashboard-startupify-list
      '(dashboard-items
        dashboard-banner
        dashboard-news))

;; ── Performance ───────────────────────────────────────────────────────────
;; Garbage collection: less frequent GC during normal use
(setq gc-cons-threshold (* 100 1024 1024)  ; 100 MB
      read-process-output-max (* 4 1024 1024))  ; 4 MB

;; Native compilation now works with the rebuilt emacs-plus@30

;; ── Custom Package Configurations ──────────────────────────────────────────

;; Jinx: Just-in-time, high-performance spell checking
(after! jinx
  (setq jinx-languages "en_US")
  ;; Use M-$ for spell correction (classic Emacs binding)
  (keymap-global-set "M-$" #'jinx-correct)
  (keymap-global-set "C-M-$" #'jinx-languages))

;; Yazi: Integration with the yazi terminal file manager
(use-package! yazi
  :bind
  ("C-x y" . yazi)
  :config
  (yazi-global-mode 1))

;; ── Performance improvements ─────────────────────────────────────────────

;; Disable bidirectional text scanning — big win for large files
(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Defer fontification while typing — smoother scroll/input
(setq redisplay-skip-fontification-on-input t)

;; Select help window automatically — no more C-x o every time
(setq help-window-select t)

;; ── LSP (Eglot) Configuration ────────────────────────────────────────────
(after! eglot
  ;; Auto-start Eglot in supported major modes
  ;; Eglot auto-detects servers based on `eglot-server-programs'
  ;; Install LSP servers via your package manager:
  ;;   brew install bash-language-server lua-language-server pyright
  ;;   npm install -g yaml-language-server vscode-json-languageserver
  (add-to-list 'eglot-server-programs '(sh-mode . ("bash-language-server" "start")))
  (add-to-list 'eglot-server-programs '(lua-mode . ("lua-language-server")))
  ;; Increase Eglot's response timeout for large projects
  (setq eglot-sync-connect nil
        eglot-connect-timeout 30))

;; ── Org mode visual enhancements ──────────────────────────────────────────

;; Org-modern: cleaner, more modern org-mode rendering
;; Global mode automatically activates in any org buffer
(global-org-modern-mode 1)

;; Org-appear: auto-show emphasis markers when cursor enters text
;; Global mode — only activates in org-mode buffers
(org-appear-mode 1)
(setq org-appear-autoemphasis t
      org-appear-autolinks t)

;; Mixed-pitch: proportional font in org-mode for a word-processor feel
(setq mixed-pitch-set-height t)
(add-hook 'org-mode-hook #'mixed-pitch-mode)

;; Valign: visually align org tables
(after! valign
  (add-hook 'org-mode-hook #'valign-mode))

;; Org structure templates: type <sh TAB to get #+BEGIN_SRC sh ... #+END_SRC
(after! org
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("lua" . "src lua"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("js" . "src javascript"))
  (add-to-list 'org-structure-template-alist '("json" . "src json")))

;; ── Custom Keybinds ──────────────────────────────────────────────────────
;; Note: Doom already provides extensive keybinds. These are just extras.

(map! :leader
      ;; Quick access to your org directory
      :desc "Find file in ~/org/" "f o" (cmd! (find-file "~/org/"))
      ;; Quick eval (SPC c e already does eval-buffer-or-region, these are extra shortcuts)
      :desc "Eval buffer" "e b" #'eval-buffer
      :desc "Eval region" "e r" #'eval-region
      ;; Org capture (inbox) - SPC x
      :desc "Org capture (inbox)" "x" #'org-capture)
