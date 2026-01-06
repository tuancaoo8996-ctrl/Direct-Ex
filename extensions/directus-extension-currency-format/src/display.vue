<template>
	<div class="currency-formatter">
		<span v-if="formattedValue !== null && formattedValue !== undefined">
			{{ formattedValue }}
		</span>
		<span v-else class="empty">—</span>
	</div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
	value: number | string | null | undefined;
	currency?: string;
	locale?: string;
	showSymbol?: boolean;
	minimumFractionDigits?: number;
}

const props = withDefaults(defineProps<Props>(), {
	currency: 'USD',
	locale: 'en-US',
	showSymbol: true,
	minimumFractionDigits: 2,
});

const formattedValue = computed(() => {
	const value = props.value;

	if (value === null || value === undefined || value === '') {
		return null;
	}

	const numValue = typeof value === 'string' ? parseFloat(value) : value;

	if (isNaN(numValue)) {
		return value;
	}

	try {
		const formatter = new Intl.NumberFormat(props.locale, {
			style: 'currency',
			currency: props.currency,
			minimumFractionDigits: props.minimumFractionDigits,
			maximumFractionDigits: props.minimumFractionDigits,
		});

		let formatted = formatter.format(numValue);

		if (!props.showSymbol) {
			formatted = formatted.replace(/[^\d.,\s-]/g, '').trim();
		}

		return formatted;
	} catch (error) {
		return numValue.toLocaleString(props.locale, {
			minimumFractionDigits: props.minimumFractionDigits,
			maximumFractionDigits: props.minimumFractionDigits,
		});
	}
});
</script>

<style scoped>
.currency-formatter {
	font-weight: 500;
}

.currency-formatter .empty {
	color: var(--theme--foreground-subdued);
	font-style: italic;
}
</style>
