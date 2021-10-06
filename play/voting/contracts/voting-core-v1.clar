
;; voting
;; <add a description here>

;; non-fungible token
;;

(define-non-fungible-token voter-identifier principal)

;; data maps and vars
;;

(define-map voters { address: principal } { voter-id: int })
(define-map votes { vote-id: int } { voter-id: int, result: int } )

(define-data-var last-voter-id int 0)
(define-data-var last-vote-id int 0)
(define-data-var vote-ids (list 100 int) (list ))


;; public functions
;;

;; register contract caller principal
;;
;; increase last-voter-id data variable by u1
;; insert contract caller principal and last-voter-id data variable into map
;; mint nft voter-identifier with the asset and owner of contract caller principal
;;

(define-public (voter-registration)
    (begin
        (var-set last-voter-id (+ 1 (var-get last-voter-id)))
        (map-insert voters { address: tx-sender } { voter-id: (var-get last-voter-id) })
        (ok (try! (nft-mint? voter-identifier tx-sender tx-sender)))
    )
)

;; get voter-id from the voters map based on the principal result of the ntf-get-owner? function
;;

(define-public (voter-id)
    (ok (unwrap! (get voter-id (map-get? voters { address: (unwrap! (nft-get-owner? voter-identifier tx-sender) (err u1)) })) (err u2)))
)

;; retrive result variable value
;; get voter-id result from previous function
;; throw error if voter-id does not exist for contract call principal
;; insert result into votes map based on voter-id key
;; return true or false
;;

(define-public (vote (result int))
    (begin
        (var-set last-vote-id (+ 1 (var-get last-vote-id)))
        (var-set vote-ids (unwrap-panic (as-max-len? (concat (list (var-get last-vote-id)) (var-get vote-ids)) u100)))
        (ok (map-insert votes { vote-id: (var-get last-vote-id) } { result: result, voter-id: (unwrap! (voter-id) (err u3)) }))
    )
)

;; get vote result variable value based on voter-id
;;

(define-read-only (vote-result (id int))
    (map-get? votes { vote-id: id })
)

(define-read-only (vote-results)
    (filter is-vote-result (map vote-result (var-get vote-ids))))

(define-private (is-vote-result (result (optional { result: int, voter-id: int })))
  (is-some result))
