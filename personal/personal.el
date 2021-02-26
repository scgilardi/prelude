;;(global-nlinum-mode -1)
(menu-bar-mode -1)
(global-undo-tree-mode -1)

(prelude-require-packages '(
                            flycheck-elixir
                            use-package
                            web-mode
                            ))

;; ----------
;; https://blog.evalcode.com/phoenix-liveview-inline-syntax-highlighting-for-emacs/
;; Assumes web-mode and elixir-mode are already set up
;; ----------
(use-package polymode
  :ensure t
  :mode ("\.ex$" . poly-elixir-web-mode)
  :config
  (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
  (define-innermode poly-liveview-expr-elixir-innermode
    :mode 'web-mode
    :head-matcher (rx line-start (* space) "~L" (= 3 (char "\"'")) line-end)
    :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
    :head-mode 'host
    :tail-mode 'host
    :allow-nested nil
    :keep-in-mode 'host
    :fallback-mode 'host)
  (define-polymode poly-elixir-web-mode
    :hostmode 'poly-elixir-hostmode
    :innermodes '(poly-liveview-expr-elixir-innermode))
  )
(setq web-mode-engines-alist '(("elixir" . "\\.ex\\'")))

;; ----------
;; https://dev.to/erickgnavar/minimal-setup-for-elixir-development-in-emacs-5k4
;; ----------
(use-package elixir-mode
  :ensure t
  :bind (:map elixir-mode-map
              ("C-c C-f" . elixir-format)))

(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode)
         (conf-mode . yas-minor-mode)
         (text-mode . yas-minor-mode)
         (snippet-mode . yas-minor-mode)))

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet))
