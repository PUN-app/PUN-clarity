
;; main
;; <add a description here>

;; constants
;;

;; data maps and vars
;;
(define-data-var hello (string-utf8 100) u"double trouble")

;; private functions
;;

;; public functions
;;
(define-read-only (say-hello)
    (ok (var-get hello))
)
(define-public (say (something (string-utf8 255)))
    (ok something)
)