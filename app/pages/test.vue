<template>
	<div>
		<ul>
      <li v-for="tenant in tenants" v-bind:key="tenant.id">
        <div>{{tenant.name}}</div>
        <div>{{tenant.target_number_of_residents}}</div>
      </li>
		</ul>
	</div>
</template>

<script>
	export default {
		async asyncData({ $axios }) {
			// リクエスト（Get）
			const res = await $axios.$get('api/v1/tenants');
			// 配列で返ってくるのでJSONにして返却
			return {
				tenants: res
			};
		}
	};
</script>