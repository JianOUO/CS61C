#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* TODO: Implement ll_has_cycle */
    if (head == NULL) {
        return 0;
    }
    node *fast_ptr, *slow_ptr;
    fast_ptr = slow_ptr = head;
    int i;
    while (1) {
        for (i = 0; i < 2; i++) {
            fast_ptr = fast_ptr->next;
            if (fast_ptr == NULL) {
                return 0;
            }
        }
        slow_ptr = slow_ptr->next;
        if (slow_ptr == fast_ptr) {
            return 1;
        }
    }
}
