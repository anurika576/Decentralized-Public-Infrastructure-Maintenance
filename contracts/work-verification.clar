;; Work Verification Contract
;; Records completed maintenance activities

(define-data-var next-work-id uint u1)

(define-map work-records
  { work-id: uint }
  {
    request-id: uint,
    asset-id: uint,
    contractor: principal,
    start-date: uint,
    completion-date: uint,
    description: (string-utf8 500),
    cost: uint,
    verified: bool,
    verifier: (optional principal)
  }
)

(define-public (record-work (request-id uint) (asset-id uint) (description (string-utf8 500)) (cost uint))
  (let (
    (work-id (var-get next-work-id))
    (current-time (unwrap-panic (get-block-info? time u0)))
  )
    (begin
      (map-set work-records
        { work-id: work-id }
        {
          request-id: request-id,
          asset-id: asset-id,
          contractor: tx-sender,
          start-date: current-time,
          completion-date: u0,
          description: description,
          cost: cost,
          verified: false,
          verifier: none
        }
      )
      (var-set next-work-id (+ work-id u1))
      (ok work-id)
    )
  )
)

(define-public (complete-work (work-id uint))
  (let (
    (work (map-get? work-records { work-id: work-id }))
    (current-time (unwrap-panic (get-block-info? time u0)))
  )
    (if (and (is-some work) (is-eq (get contractor (unwrap-panic work)) tx-sender))
      (begin
        (map-set work-records
          { work-id: work-id }
          (merge (unwrap-panic work) { completion-date: current-time })
        )
        (ok true)
      )
      (err u1)
    )
  )
)

(define-public (verify-work (work-id uint))
  (let ((work (map-get? work-records { work-id: work-id })))
    (if (is-some work)
      (begin
        (map-set work-records
          { work-id: work-id }
          (merge (unwrap-panic work) {
            verified: true,
            verifier: (some tx-sender)
          })
        )
        (ok true)
      )
      (err u1)
    )
  )
)

(define-read-only (get-work-record (work-id uint))
  (ok (map-get? work-records { work-id: work-id }))
)

(define-read-only (get-asset-work-history (asset-id uint))
  ;; This is a simplified version - in a real contract, you would implement
  ;; a way to return all work records for an asset
  (ok true)
)
