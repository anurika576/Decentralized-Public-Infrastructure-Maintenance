;; Asset Registration Contract
;; Records details of public infrastructure assets

(define-data-var next-asset-id uint u1)

;; Asset types: 1=Road, 2=Bridge, 3=Park, 4=Building, 5=Utility
(define-map assets
  { asset-id: uint }
  {
    asset-type: uint,
    location: (string-utf8 100),
    installation-date: uint,
    last-maintenance: uint,
    status: uint  ;; 1=Good, 2=Fair, 3=Poor, 4=Critical
  }
)

(define-public (register-asset (asset-type uint) (location (string-utf8 100)) (installation-date uint))
  (let
    ((asset-id (var-get next-asset-id)))
    (begin
      (map-set assets
        { asset-id: asset-id }
        {
          asset-type: asset-type,
          location: location,
          installation-date: installation-date,
          last-maintenance: u0,
          status: u1
        }
      )
      (var-set next-asset-id (+ asset-id u1))
      (ok asset-id)
    )
  )
)

(define-read-only (get-asset (asset-id uint))
  (ok (map-get? assets { asset-id: asset-id }))
)

(define-public (update-asset-status (asset-id uint) (new-status uint))
  (let ((asset (map-get? assets { asset-id: asset-id })))
    (if (is-some asset)
      (begin
        (map-set assets
          { asset-id: asset-id }
          (merge (unwrap-panic asset) { status: new-status })
        )
        (ok true)
      )
      (err u1)
    )
  )
)

(define-public (update-last-maintenance (asset-id uint) (maintenance-date uint))
  (let ((asset (map-get? assets { asset-id: asset-id })))
    (if (is-some asset)
      (begin
        (map-set assets
          { asset-id: asset-id }
          (merge (unwrap-panic asset) { last-maintenance: maintenance-date })
        )
        (ok true)
      )
      (err u1)
    )
  )
)
