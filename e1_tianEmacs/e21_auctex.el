
;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
(require 'tex-site)   ; invoke the AUCTeX package (LaTeX support)
(if (string-equal system-type "windows-nt")
    (require 'tex-mik))
(add-to-list 'auto-mode-alist '("\\.tex$" . LaTeX-mode))

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-electric-escape t)
(setq TeX-electric-sub-and-superscript t)
(setq-default TeX-master t) ; t for not ask 
(setq TeX-engine 'xetex)  ; or latex, pdftex
(setq preview-scale-function 1.5)
(setq TeX-auto-untabify t)     ; remove all tabs before saving
(setq TeX-save-query nil)
(setq TeX-show-compilation t) ; display compilation windows

            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
          
            (imenu-add-menubar-index)
                 ;;(setq TeX-open-quote "«~")
                 ;;(setq TeX-close-quote "~»")
            (define-key LaTeX-mode-map (kbd "C-TAB") 'TeX-complete-symbol)))
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode 
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flycheck-mode)
(add-hook 'LaTeX-mode-hook 'linum-mode)
(add-hook 'LaTeX-mode-hook 'folding-mode)
(add-hook 'LaTeX-mode-hook 'font-lock-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'TeX-mode-hook 'font-lock-mode)
(require 'cdlatex)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Use Okular as the pdf viewer. Build okular 
  ;; command, so that Okular jumps to the current line 
  ;; in the viewer.
  ;; (setq TeX-view-program-selection
  ;;  '((output-pdf "PDF Viewer")))
  ;; (setq TeX-view-program-list
  ;;  '(("PDF Viewer" "okular --unique %o#src:%n%b")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-indent-level 4)
 '(TeX-PDF-mode t)
 '(TeX-engine (quote xetex))
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list (quote (("Okular" "okular --unique %o#src:%n%b"))))
 '(TeX-view-program-selection (quote ((output-pdf "Okular"))))
 '(show-paren-mode t))

(setq TeX-source-correlate-method 'synctex)
;; Enable synctex generation. Even though the command shows
;; as "latex" pdflatex is actually called
(custom-set-variables '(LaTeX-command "latex -synctex=1") )

(require 'magic-latex-buffer)
(add-hook 'LaTex-mode-hook 'magic-latex-buffer)

(setq org-latex-pdf-process
          '("pdflatex -interaction nonstopmode -output-directory %o %f"
            "bibtex %b"
            "pdflatex -interaction nonstopmode -output-directory %o %f"
            "pdflatex -interaction nonstopmode -output-directory %o %f"))
  ;; (setq org-latex-pdf-process
  ;;         '("pdflatex -interaction nonstopmode -output-directory %o %f"
  ;;           "biber %b"
  ;;           "pdflatex -interaction nonstopmode -output-directory %o %f"
  ;;           "pdflatex -interaction nonstopmode -output-directory %o %f"))
;;;; biber
;; (setq org-latex-to-pdf-process 
;;    '("pdflatex %f" "biber %b" "pdflatex %f" "pdflatex %f"))

;;(require 'latex-pretty-symbols)

;; sudo apt-get install whizzytex
(autoload 'whizzytex-mode "whizzytex" "WhizzyTeX, a minor-mode WYSIWIG environment for LaTeX" t)
(setq my-toggle-whizzy-count 0)
(defun my-toggle-whizzy-mode ()
  (interactive)
  (if (= (mod my-toggle-whizzy-count 2) 0)
      (progn
        (whizzytex-mode)
        (message "WhizzyTeX on"))
    (progn
      (whizzy-mode-off)
      (kill-buffer (concat "*" (buffer-name) "*"))
      (message "WhizzyTeX off")))
  (setq my-toggle-whizzy-count (+ my-toggle-whizzy-count 1)))
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (define-key LaTeX-mode-map (kbd "<f9>") 'my-toggle-whizzy-mode)))
;; (setq LaTeX-default-options '("a4"))
;; (setq LaTeX-float "hbt")
;; (setq LaTeX-indent-level 2)
;; (setq LaTeX-item-indent 0)
;; (setq LaTeX-brace-indent-level 2)
;; ;;
;; (add-hook 'tex-mode-hook
;;        (function
;;         (lambda ()
;;           (font-lock-mode 1))))
;; ;;
;; (add-hook 'LaTeX-mode-hook
;;        (function
;;         (lambda ()
;;           (run-hooks 'tex-mode-hook))))

;; (setq TeX-open-quote "<<")
;; (setq TeX-close-quote ">>")
;; (setq TeX-insert-braces nil)
;; (setq preview-scale-function 1.3)
;; (setq LaTeX-math-menu-unicode t)
;; (require 'ac-math) ;; Latex Completion
;; (add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of {{{latex-mode}}}
;; (defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
;;   (setq ac-sources
;;      (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
;;                ac-sources)))
;; (add-hook 'latex-mode-hook 'ac-latex-mode-setup)
;; (ac-flyspell-workaround)
