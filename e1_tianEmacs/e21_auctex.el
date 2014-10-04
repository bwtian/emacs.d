
;; (setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))
  (require 'tex-site)   ; invoke the AUCTeX package (LaTeX support)
  (if (string-equal system-type "windows-nt")
      (require 'tex-mik))
(setq TeX-file-extensions
      '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))

(load "auctex.el" nil t t)
;;(load "auctex-pkg.el" nil t t)
;;(load "latex.el" nil t t) ;; import for not ask master files

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq LaTeX-math-mode t)
(setq TeX-electric-escape t)
(setq TeX-engine 'pdflatex)
(setq TeX-PDF-mode t) ;; use pdflatex instead of latex by default

(setq TeX-source-correlate-method 'synctex)
;; Enable synctex generation. Even though the command shows
;; as "latex" pdflatex is actually called
(custom-set-variables '(LaTeX-command "latex -synctex=1") )

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'linum-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'folding-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; enable auto-fill mode, nice for text
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;(load "preview-latex.el" nil t t)
(load "preview.el" nil t t)

;;(require 'latex-pretty-symbols)

(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use Okular as the pdf viewer. Build okular 
;; command, so that Okular jumps to the current line 
;; in the viewer.
(setq TeX-view-program-selection
 '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
 '(("PDF Viewer" "okular --unique %o#src:%n%b")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq TeX-view-program-list
        '(("SumatraPDF" "SumatraPDF.exe %o") ;;Windows
          ("Gsview" "gsview32.exe %o")
          ("Okular" "okular --unique %o")
          ("Evince" "evince %o")    ;; Gnomeers
          ("Firefox" "firefox %o")))
  (cond
   ((eq system-type 'windows-nt)
    (add-hook 'LaTeX-mode-hook
              (lambda ()
                (setq TeX-view-program-selection '((output-pdf "SumatraPDF")
                                                   (output-dvi "Yap"))))))
   ((eq system-type 'gnu/linux)
    (add-hook 'LaTeX-mode-hook
              (lambda ()
                (setq TeX-view-program-selection '((output-pdf "Okular")
                                                   (output-dvi "Okular")))))))

  (setq TeX-output-view-style (quote (
                                      ("^pdf$" "." "evince %o")
                                      ("^ps$" "." "gv %o")
                                      ("^dvi$" "." "xdvi %o")
                                      )))
  (setq tex-dvi-view-command "xdvi")
  (setq tex-dvi-print-command "dvips")
  (setq tex-alt-dvi-print-command "dvips")

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
