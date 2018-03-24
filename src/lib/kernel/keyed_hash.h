#ifndef __LIB_KERNEL_KEYED_HASH_H
#define __LIB_KERNEL_KEYED_HASH_H

#include <hash.h>

/* Everything in here is pretty lightweight, so method are made inline. */

/* A hash key is an ADT that allows us to look up hashed objects.
 * In order to use it, your object must be castable to this type.
 * Perhaps in the future this can be made more generic to include
 * keys of other types. */
struct hash_key {
  int key;
  struct hash_elem elem;
};

/* This function can hash both complete objects and hash_keys.
 * (hash keys are castable to their raw value, and objects are
 * castable to their keys) */
static inline unsigned
hash_key_func (const void *a) {
  int *key = (int*) a;
  return hash_int (*key);
}

/* Standard less than function that operates on keys. */
static inline bool
hash_key_less (const struct hash_elem *a, const struct hash_elem *b) {
  struct hash_key *t1 = hash_entry (a, struct hash_key, elem);
  struct hash_key *t2 = hash_entry (b, struct hash_key, elem);
  return t1->key < t2->key;
}

/* Wouldn't want to type this out every time I wanted to make a hash table. */
#define keyed_hash_init(h)          \
  hash_init (h,                     \
  (hash_hash_func*) hash_key_func,  \
  (hash_less_func*) hash_key_less,  \
  NULL)

/* Wrapper Functions */

/* These functions just create a hash_key struct and use the
 * original hash functions, so check hash.h for documentation
 * on hash_find and hash_delete.
 *
 * As far as I know, these functions are safer to use because
 * elem is completely blank and will never conflict with any
 * existing elements in the hash table. */

static inline struct hash_elem*
hash_lookup_key(struct hash *h, int k) {
  struct hash_key key = { k, {} };
  return hash_find (h, &key.elem);
}

static inline struct hash_elem*
hash_delete_key (struct hash *h, int k) {
  struct hash_key key = { k, {} };
  return hash_delete (h, &key.elem);
}

#endif
