;; $HOME/.emacs.d/init.el



(setq package-check-signature nil)	; for the error about 'Failed to verify signature archive-contents.sig'

(require 'package)
(setq use-package-always-ensure t)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")
 	     '("melpa-stable" . "http://stable.melpa.org/packages/"))												                             

;; (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;; 			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
;; 			 ("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
			 ;; ("melpa-stable2" . "https://stable.melpa.org/packages/")
;; 			 ("marmalada" . "http://elpa.emacs-china.org/marmalade/")))


(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setenv "PATH" (concat (getenv "PATH") ":/usr/bin"))

;; c
(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(if (version< emacs-version "24.4")
    (require 'setup-ivy-counsel)
  (require 'setup-helm)
  (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)

;;
(add-hook 'python-mode-hook 'anaconda-mode)

;;自动补全括号
(electric-pair-mode t)

;;隐藏侧边栏工具栏
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(load-theme 'zenburn t)

;;(setenv "PATH" (concat (getenv "PATH") ":/usr/bin"))

;; install helm if not installed
(unless (package-installed-p 'helm)
    	(package-refresh-contents)
      	(package-install 'helm))

;; helm config
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-i") 'helm-swoop)

(with-eval-after-load 'helm
		        ;; (define-key helm-map (kbd "C-c p") 'ignore)
	(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
	(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
	(define-key helm-map (kbd "C-z")  'helm-select-action))


(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)


;; projectile 配置
(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-p") 'projectile-command-map)

;;窗口调整
;; (require 'windresize)
;; (global-set-key (kbd "C-c m") 'windresize）

;; undo-tree
(unless (package-installed-p 'undo-tree)
  (package-refresh-contents)
  (package-install 'undo-tree))

;; undo-tree config

(add-hook 'after-init-hook 'global-undo-tree-mode)

;;org-mode
(with-eval-after-load 'org
  (setq org-todo-keywords
		'((sequence "TODO(t)" "|" "ONGOING(g)" "|" "DONE(d)")
		  (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
		  (sequence "|" "CANCELED(c)"))))


(with-eval-after-load 'org
  (setq org-log-done 'time))

(with-eval-after-load 'org
  (setq org-log-done 'note))
(with-eval-after-load 'org
  (add-to-list 'org-export-backends 'md))


(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c 9") 'org-time-stamp)
;;org-mode 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))


;; window-numbering

(unless (package-installed-p 'window-numbering)

  (package-refresh-contents)

  (package-install 'window-numbering))

;; window-numbering config

(window-numbering-mode 1)



;; elpy

(unless (package-installed-p 'elpy)

  (package-refresh-contents)

  (package-install 'elpy))

;; elpy Config

;; helm-swoop

(unless (package-installed-p 'helm-swoop)

  (package-refresh-contents)

  (package-install 'helm-swoop))



;; yasnippet

(unless (package-installed-p 'yasnippet)

  (package-refresh-contents)

  (package-install 'yasnippet))

;; yasnippet config

;;(yas-global-mode 1)

;;(setq yas-snippet-dirs
;;      '("~/.emacs.d/snippets"                 ;; personal snippets
;;	))


;; magit
(unless (package-installed-p 'magit)
  
  (package-refresh-contents)

  (package-install 'magit))


;; magit config
(global-set-key (kbd "C-x g") 'magit-status)


;; autopair
;;(unless (package-installed-p 'autopair)
;;  (package-refresh-contents)
;;  (package-install 'autopair))



;; Global Config

(fset 'yes-or-no-p 'y-or-n-p)

(when (fboundp 'winner-mode)
      (winner-mode)
      (windmove-default-keybindings))

(setq inhibit-startup-message t)

(global-linum-mode 1)

(put 'set-goal-column 'disabled nil)

(tool-bar-mode -1)
(show-paren-mode 1)
(setq tramp-default-method "ssh")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/schedule/2020/07/2020-07-11.org" "~/schedule/2020/06/2020-06-05.org" "~/schedule/2020/06/2020-06-04.org" "~/schedule/2020/06/2020-06-03.org" "~/schedule/2020/06/2020-06-02.org"))
 '(package-selected-packages
   '(anaconda-mode calendar-norway windresize windsize company-c-headers function-args sr-speedbar go-fill-struct go-errcheck go-complete go-autocomplete go go-imports go-rename neotree monokai-theme spacemacs-theme zenburn-theme go-imenu go-playground hc-zenburn-theme autopair magit helm-swoop elpy window-numbering undo-tree helm))
 '(safe-local-variable-values
   '((company-clang-arguments "-I/usr/lib64/mpi/gcc/openmpi/include/" "-I/home/xingzheng/mpi-exp/perf/" "-I/usr/include/" "-I/usr/local/include/")
     (company-clang-arguments "-I/usr/lib64/mpi/gcc/openmpi/include/" "-I/home/xingzheng/mpi-exp/perf/" "-I/usr/include/")
     (company-clang-arguments "-I/usr/lib64/mpi/gcc/openmpi/include/"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
